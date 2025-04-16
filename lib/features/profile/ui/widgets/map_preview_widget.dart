import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/theming/colors.dart';

class MapPreviewWidget extends StatefulWidget {
  final LatLng selectedLocation;
  final Set<Marker> markers;
  final VoidCallback openFullScreenMap;
  final VoidCallback pinCurrentLocation;
  final CameraPosition initialCameraPosition;
  final Function(GoogleMapController) onMapCreated;
  final bool isMapReady;

  const MapPreviewWidget({
    super.key,
    required this.selectedLocation,
    required this.markers,
    required this.openFullScreenMap,
    required this.pinCurrentLocation,
    required this.initialCameraPosition,
    required this.onMapCreated,
    required this.isMapReady,
  });

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.openFullScreenMap,
      child: Stack(
        children: [
          Container(
            height: 240.h,
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
                    initialCameraPosition: widget.initialCameraPosition,
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
                    onTap: (LatLng location) {
                      widget.openFullScreenMap();
                    },
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
          Positioned(
            right: 16.w,
            top: 60.h,
            child: GestureDetector(
              onTap: widget.pinCurrentLocation,
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
                  Icons.location_on,
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
}
