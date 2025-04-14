import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


import '../../../core/theming/colors.dart';

class FullScreenMapPicker extends StatefulWidget {
  final LatLng initialLocation;
  final String initialAddress;
  final String apiKey;

  const FullScreenMapPicker({
    super.key,
    required this.initialLocation,
    required this.initialAddress,
    required this.apiKey,
  });

  @override
  State<FullScreenMapPicker> createState() => _FullScreenMapPickerState();
}

class _FullScreenMapPickerState extends State<FullScreenMapPicker> {
  final bool _isMounted = true;
  late LatLng _selectedLocation;
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  bool _isDraggingMap = false;
  String _area = '';

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    _searchController.text = widget.initialAddress;
    _updateMarker();
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateMarker() {
    _markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: _selectedLocation,
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            _selectedLocation = newPosition;
          });
          _updateAddressFromCoordinates(newPosition);
        },
      ),
    };
  }

  Future<void> _updateAddressFromCoordinates(LatLng position) async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${widget.apiKey}'));

      // Check if widget is still mounted before updating state
      if (!_isMounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final address = data['results'][0]['formatted_address'];

          // Extract area from address components if available
          if (data['results'][0]['address_components'] != null) {
            final components = data['results'][0]['address_components'] as List;
            for (final component in components) {
              final types = component['types'] as List;
              if (types.contains('neighborhood') ||
                  types.contains('sublocality') ||
                  types.contains('sublocality_level_1')) {
                _area = component['long_name'];
                break;
              }
            }
          }

          setState(() {
            _searchController.text = address;
          });
        }
      }
    } catch (e) {
      log('Error getting address: $e');
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=geocode&key=${widget.apiKey}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['predictions'] != null) {
          setState(() {
            _searchResults = List<Map<String, dynamic>>.from(
              data['predictions'].map((prediction) => {
                    'place_id': prediction['place_id'],
                    'description': prediction['description'],
                  }),
            );
          });
        }
      }
    } catch (e) {
      log('Error searching places: $e');
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,formatted_address,address_component&key=${widget.apiKey}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] != null) {
          final location = data['result']['geometry']['location'];
          final latLng = LatLng(location['lat'], location['lng']);
          final address = data['result']['formatted_address'];

          // Try to extract area information
          _area = '';
          if (data['result']['address_components'] != null) {
            final components = data['result']['address_components'] as List;
            for (final component in components) {
              final types = component['types'] as List;
              if (types.contains('neighborhood') ||
                  types.contains('sublocality') ||
                  types.contains('sublocality_level_1')) {
                _area = component['long_name'];
                break;
              }
            }
          }

          setState(() {
            _selectedLocation = latLng;
            _searchController.text = address;
            _isSearching = false;
            _searchResults = [];
            _updateMarker();
          });

          _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(latLng, 15),
          );
        }
      }
    } catch (e) {
      log('Error getting place details: $e');
    }
  }

  Future<void> _pinCurrentLocation() async {
    try {
      // Request current location permission
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        _showSnackBar('Location services are disabled');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSnackBar('Location permissions are permanently denied');
        return;
      }

      // Get current position
      final Position position = await Geolocator.getCurrentPosition();
      final LatLng currentLocation =
          LatLng(position.latitude, position.longitude);

      setState(() {
        _selectedLocation = currentLocation;
        _updateMarker();
      });

      // Update address from coordinates
      _updateAddressFromCoordinates(currentLocation);

      // Update map view
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 15),
      );

      _showSnackBar('Current location pinned');
    } catch (e) {
      log('Error getting current location: $e');
      _showSnackBar('Could not get current location');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.black,
            size: 20.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorsManager.lightGrey),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a location',
                prefixIcon:
                    const Icon(Icons.search, color: ColorsManager.darkGray),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              onChanged: (value) {
                _searchPlaces(value);
              },
            ),
          ),

          // Search results
          if (_isSearching && _searchResults.isNotEmpty)
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ColorsManager.lightGrey),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _searchResults[index]['description'],
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onTap: () {
                        _getPlaceDetails(_searchResults[index]['place_id']);
                      },
                    );
                  },
                ),
              ),
            ),

          // Map
          if (!_isSearching || _searchResults.isEmpty)
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation,
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: false,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    onTap: (LatLng location) {
                      setState(() {
                        _selectedLocation = location;
                        _updateMarker();
                      });
                      _updateAddressFromCoordinates(location);
                    },
                    onCameraMoveStarted: () {
                      setState(() {
                        _isDraggingMap = true;
                      });
                    },
                    onCameraMove: (CameraPosition position) {
                      // Track camera position during movement
                    },
                    onCameraIdle: () {
                      if (_isDraggingMap) {
                        _mapController.getVisibleRegion().then((bounds) {
                          final centerLat = (bounds.northeast.latitude +
                                  bounds.southwest.latitude) /
                              2;
                          final centerLng = (bounds.northeast.longitude +
                                  bounds.southwest.longitude) /
                              2;
                          final centerPosition = LatLng(centerLat, centerLng);

                          setState(() {
                            _selectedLocation = centerPosition;
                            _updateMarker();
                            _isDraggingMap = false;
                          });

                          _updateAddressFromCoordinates(centerPosition);
                        });
                      }
                    },
                  ),

                  // Center indicator
                  if (_isDraggingMap)
                    Center(
                      child: Icon(
                        Icons.location_pin,
                        color: ColorsManager.mainRose,
                        size: 40.sp,
                      ),
                    ),

                  // Instruction text
                  Positioned(
                    top: 16.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: ColorsManager.black
                              .withAlpha((0.6 * 255).toInt()),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Drag map or marker to adjust location',
                          style: TextStyle(
                            color: ColorsManager.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // My location button
                  Positioned(
                    bottom: 16.h,
                    right: 16.w,
                    child: InkWell(
                      onTap: () {
                        _pinCurrentLocation();
                        _mapController.animateCamera(
                          CameraUpdate.newLatLng(_selectedLocation),
                        );
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.black
                                  .withAlpha((0.1 * 255).toInt()),
                              blurRadius: 4.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.my_location,
                          color: ColorsManager.black87,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  ],
              ),
            ),

          // Selected location information & Confirm button
          Container(
            width: double.infinity,
            color: ColorsManager.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_searchController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Location:',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.darkGray,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _searchController.text,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ElevatedButton( 
                  onPressed: () {
                    // Pop with data and prevent multiple navigations
                    // if (Navigator.canPop(context)) {
                    //   // Ensure we have valid data to return
                    //   final locationData = {
                    //     'location': _selectedLocation,
                    //     'address': _searchController.text,
                    //     'area': _area,
                    //   };

                    //   // Pop only once with the result data
                    Navigator.of(context).pop({
                      'location': _selectedLocation,
                      'address': _searchController.text,
                      'area': _area,
                    });
                    // }
                    // context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006A78),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                  child: Text(
                    'Confirm Location',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
