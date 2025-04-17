import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';

import '../../../../../../core/theming/colors.dart';

class MapPreviewWidget extends StatefulWidget {
  final VoidCallback openFullScreenMap;
  final Function(String) showMessage;
  final Function(LatLng, String, String)? onLocationUpdated;
  final LatLng? initialLocation;
  final Set<Marker> markers;
  final String currentAddress;
  final String currentArea;
  final Function(GoogleMapController) onMapCreated;
  final VoidCallback onGetCurrentLocation;

  const MapPreviewWidget({
    super.key,
    required this.openFullScreenMap,
    required this.showMessage,
    this.onLocationUpdated,
    required this.initialLocation,
    required this.markers,
    required this.currentAddress,
    required this.currentArea,
    required this.onMapCreated,
    required this.onGetCurrentLocation,
  });

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.openFullScreenMap,
      child: Stack(
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorsManager.lightGrey),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: widget.initialLocation ??
                          const LatLng(30.0444, 31.2357), // Default to Cairo
                      zoom: 14.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    compassEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    markers: widget.markers,
                    onMapCreated: widget.onMapCreated,
                    onTap: (_) => widget.openFullScreenMap(),
                  ),

                  // Show loading indicator if in loading state
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),

                  // Instruction text
                  Positioned(
                    top: 8.h,
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
                          'Tap to open map picker',
                          style: TextStyle(
                            color: ColorsManager.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Full-screen overlay to make entire map clickable
                  Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pin location button
          Positioned.directional(
            end: 10.w,
            top: 10.h,
            textDirection: context.read<GeneralCubit>().lang == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: GestureDetector(
              onTap: () => _handleGetCurrentLocation(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.my_location_outlined,
                  color: ColorsManager.mainRose,
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGetCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Check location services and permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        widget.showMessage(
            'Location services are disabled. Please enable them in settings.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          widget.showMessage(
              'Location permission denied. Please grant permission to use this feature.');
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission Required'),
            content: const Text(
              'Location permission is permanently denied. Please enable it in app settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Geolocator.openLocationSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Call the parent's getCurrentLocation method
      widget.onGetCurrentLocation();
    } catch (e) {
      widget.showMessage('Error getting current location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
