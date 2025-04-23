import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/address/ui/full_screen_map_picker.dart';
import 'package:wardaya/core/config/env_config.dart';

class DetailsCompactMapPreview extends StatefulWidget {
  final LatLng location;
  final Function(LatLng, String, String) onLocationChanged;
  final double height;
  final bool showFullscreenButton;
  final double borderRadius;
  final String address;
  final String area;

  const DetailsCompactMapPreview({
    super.key,
    required this.location,
    required this.onLocationChanged,
    this.height = 200,
    this.showFullscreenButton = true,
    this.borderRadius = 8,
    this.address = '',
    this.area = '',
  });

  @override
  State<DetailsCompactMapPreview> createState() =>
      _DetailsCompactMapPreviewState();
}

class _DetailsCompactMapPreviewState extends State<DetailsCompactMapPreview> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: widget.location,
      ),
    };
  }

  @override
  void didUpdateWidget(DetailsCompactMapPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('selected_location'),
            position: widget.location,
          ),
        };
      });
      _controller?.animateCamera(
        CameraUpdate.newLatLng(widget.location),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          child: SizedBox(
            height: widget.height.h,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.location,
                zoom: 15,
              ),
              markers: _markers,
              onMapCreated: (controller) => _controller = controller,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
            ),
          ),
        ),
        if (widget.showFullscreenButton)
          Positioned(
            right: 8.w,
            bottom: 8.h,
            child: FloatingActionButton.small(
              backgroundColor: ColorsManager.white,
              foregroundColor: ColorsManager.mainRose,
              child: const Icon(Icons.fullscreen),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenMapPicker(
                      initialLocation: widget.location,
                      initialAddress: widget.address,
                      apiKey: EnvConfig.mapsApiKey,
                    ),
                  ),
                );

                if (result != null && mounted) {
                  final location = result['location'] as LatLng;
                  final address = result['address'] as String;
                  final area = result['area'] as String;

                  // Pass all three values back to the parent widget
                  widget.onLocationChanged(location, address, area);
                }
              },
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
