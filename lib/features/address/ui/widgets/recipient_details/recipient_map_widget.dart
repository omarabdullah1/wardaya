import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/config/env_config.dart';
import '../../../../../core/routing/router_imports.dart';
import '../../../data/models/address_response.dart';
import '../../../logic/recipient_details_cubit/recipient_details_cubit.dart';
import '../../../logic/recipient_details_cubit/recipient_details_state.dart';
import '../../full_screen_map_picker.dart';
import 'map_preview_widget.dart';

class RecipientMapWidget extends StatefulWidget {
  final Address? address;
  const RecipientMapWidget({
    super.key,
    this.address,
  });

  @override
  State<RecipientMapWidget> createState() => _RecipientMapWidgetState();
}

class _RecipientMapWidgetState extends State<RecipientMapWidget> {
  // Initialize with a default value instead of using late
   final LatLng _defaultLocation = const LatLng(0.0, 0.0); // Cairo coordinates
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  String _currentAddress = '';
  String _currentArea = '';
  bool _isUpdatingFromMapPicker = false;
  // Add this field to track if the widget is mounted
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();

log('area: ${widget.address?.recipientAddress}');
log('lat: ${widget.address?.latitude}');
log('long: ${widget.address?.longitude}');
    // Initialize with address data if available
    if (widget.address != null) {
      // Ensure we're not using 0,0 coordinates if they're in the address
      // Ensure we're not using 0,0 coordinates if they're in the address
      if (widget.address!.latitude != 0 || widget.address!.longitude != 0) {
         _selectedLocation = LatLng(
          widget.address!.latitude,
          widget.address!.longitude,
        );
        // No need to reassign _defaultLocation here
        log('Initializing with address location: $_selectedLocation');

        // Initialize address details if available
        if (widget.address!.recipientAddress.isNotEmpty) {
          _currentAddress = widget.address!.recipientAddress;
          _currentArea = widget.address!.recipientArea;
          log('updating current address and area: $_currentAddress, $_currentArea');
          // No need to call updateLocation here, it's already done in the parent widget
        }
      } else {
        log('Address has 0,0 coordinates, using default location');
        _selectedLocation = _defaultLocation;
      }
      _updateMarkers();
    } else {
      // Try to get location from RecipientDetailsCubit after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_isMounted) return;
        
        final recipientCubit = context.read<RecipientDetailsCubit>();
        if (recipientCubit.selectedLocation != null) {
          setState(() {
            _selectedLocation = recipientCubit.selectedLocation;
            log('Using location from recipient cubit: $_selectedLocation');
            _updateMarkers();
          });
        } else {
          // Fall back to default location
          setState(() {
            _selectedLocation = _defaultLocation;
            _updateMarkers();
          });
        }
      });

      // Set default location initially to avoid null issues
      _selectedLocation = _defaultLocation;
      _updateMarkers();
    }
  }

  void _updateMarkers() {
    _markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: _selectedLocation ?? _defaultLocation,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ),
    };
  }

  void _updateMapView() {
    if (_mapController != null && _selectedLocation != null) {
      log('Updating map camera to: $_selectedLocation');
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _selectedLocation!,
            zoom: 14.0,
          ),
        ),
      );
    } else {
      log('Map controller is null or location is null, cannot update position');
    }
  }

  Future<void> animateToLocation(LatLng location) async {
    if (_mapController != null) {
      try {
        // First update the selected location
        setState(() {
          _selectedLocation = location;
          _updateMarkers();
        });

        // Then animate the camera with a try-catch to handle potential errors
        await _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(location, 14.0),
        );
      } catch (e) {
        // Log the error but don't crash
        log('Error animating camera: $e');

        // Try a simpler camera update as fallback
        try {
          await _mapController!.moveCamera(
            CameraUpdate.newLatLng(location),
          );
        } catch (e2) {
          log('Fallback camera movement also failed: $e2');
        }
      }
    } else {
      log('Map controller is null, cannot animate to location');
      // Still update the location data so it's ready when the map loads
      setState(() {
        _selectedLocation = location;
        _updateMarkers();
      });
    }
  }

  void updateLocation(LatLng location, {bool updateAddress = true}) async {
    if (!_isMounted) return;
    
    setState(() {
      _selectedLocation = location;
      _updateMarkers();
    });

    if (_mapController != null) {
      _updateMapView();
    }

    if (updateAddress) {
      try {
        final addressData = await getAddressFromCoordinates(location);
        if (!_isMounted) return;
        
        setState(() {
          _currentAddress = addressData.address;
          _currentArea = addressData.area;
        });
      } catch (e) {
        log('Error getting address: $e');
      }
    }
  }

  void updateAddressDetails(String address, String area) {
    setState(() {
      _currentAddress = address;
      _currentArea = area;
    });
  }

  Future<({String address, String area})> getAddressFromCoordinates(
      LatLng position) async {
    String address = '', area = '';
    try {
      log('Getting address from coordinates: $position');
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${EnvConfig.mapsApiKey}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          address = data['results'][0]['formatted_address'];

          // Extract area from address components if available
          if (data['results'][0]['address_components'] != null) {
            final components = data['results'][0]['address_components'] as List;
            for (final component in components) {
              final types = component['types'] as List;
              if (types.contains('neighborhood') ||
                  types.contains('sublocality') ||
                  types.contains('sublocality_level_1')) {
                area = component['long_name'];
                break;
              }
            }
          }
        }
      }
    } catch (e) {
      log('Error getting address: $e');
    }
    return (address: address, area: area);
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateMapView();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipientCubit = context.read<RecipientDetailsCubit>();

    return BlocListener<RecipientDetailsCubit, RecipientDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          locationUpdated: (location, address, area) {
            // Skip updates that come from the map picker to prevent loops
            if (_isUpdatingFromMapPicker) return;

            log('Location updated in recipient state: $location');
            updateLocation(location, updateAddress: false);
            updateAddressDetails(address, area);
          },
          orElse: () {},
        );
      },
      child: MapPreviewWidget(
        initialLocation: _selectedLocation,
        markers: _markers,
        currentAddress: _currentAddress,
        currentArea: _currentArea,
        onMapCreated: onMapCreated,
        openFullScreenMap: () => _openFullScreenMap(context),
        showMessage: showSnackBar,
        onLocationUpdated: (location, address, area) {
          recipientCubit.updateLocationData(location, address, area);
        },
        onGetCurrentLocation: _getCurrentLocation,
      ),
    );
  }

  // Add this method to handle getting current location
  // Add this field to track if the widget is mounted
// Remove duplicate declaration since _isMounted is already defined above

  // In your async methods, add checks like:
  Future<void> _getCurrentLocation() async {
    try {
      // Get current position
      final position = await Geolocator.getCurrentPosition();
      final currentLocation = LatLng(position.latitude, position.longitude);

      // Check if widget is still mounted before updating state
      if (!_isMounted) return;

      // Update selected location
      setState(() {
        _selectedLocation = currentLocation;
        _updateMarkers();
      });

      // Get address details from coordinates
      final addressData = await getAddressFromCoordinates(currentLocation);
      if (!_isMounted) return;
      
      setState(() {
        _currentAddress = addressData.address;
        _currentArea = addressData.area;
      });

      if (_mapController != null && _isMounted) {
        _updateMapView();
      }

      // Update recipient cubit if needed
      if (_isMounted) {
        final recipientCubit = context.read<RecipientDetailsCubit>();
        recipientCubit.updateLocationData(
            currentLocation, _currentAddress, _currentArea);
      }
    } catch (e) {
      if (!_isMounted) return;
      log('Error getting current location: $e');
      showSnackBar('Could not get current location: $e');
    }
  }

  Future<void> _openFullScreenMap(BuildContext context) async {
    if (!_isMounted) return;
    
    final recipientCubit = context.read<RecipientDetailsCubit>();

    final Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenMapPicker(
          initialLocation: _selectedLocation ?? _defaultLocation,
          initialAddress: recipientCubit.addressController.text,
          apiKey: EnvConfig.mapsApiKey,
        ),
      ),
    );

    if (result != null && _isMounted) {
      final LatLng location = result['location'] as LatLng;
      final String address = result['address'] as String;
      final String area = result['area'] as String;

      log('Returned from map picker with location: $location');

      // Set flag to prevent BlocListener from reacting to this update
      _isUpdatingFromMapPicker = true;

      // Update recipient cubit first
      recipientCubit.updateLocationData(location, address, area);

      // Update local state
      updateLocation(location, updateAddress: false);
      updateAddressDetails(address, area);

      // Ensure the map camera is updated to the new location
      animateToLocation(location);

      // Reset flag after a short delay to ensure all state changes are processed
      if (_isMounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_isMounted) {
            _isUpdatingFromMapPicker = false;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    // Make sure to dispose the map controller properly
    if (_mapController != null) {
      _mapController!.dispose();
      _mapController = null;
    }
    
    // Cancel any pending futures or timers
    // This helps prevent setState calls after dispose
    _isUpdatingFromMapPicker = false;
    
    super.dispose();
  }
}
