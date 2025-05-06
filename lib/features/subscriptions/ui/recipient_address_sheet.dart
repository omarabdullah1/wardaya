import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wardaya/core/config/env_config.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_text_button.dart';
import 'package:wardaya/features/subscriptions/ui/compact_map_preview.dart';

class RecipientAddressSheet extends StatefulWidget {
  final LatLng? initialLocation;
  final String initialAddress;
  final String initialArea;
  final String additional;

  const RecipientAddressSheet({
    super.key,
    this.initialLocation,
    this.initialAddress = '',
    this.initialArea = '',
    this.additional = '',
  });

  @override
  State<RecipientAddressSheet> createState() => _RecipientAddressSheetState();
}

class _RecipientAddressSheetState extends State<RecipientAddressSheet> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();
  LatLng? _selectedLocation;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedLocation =
        widget.initialLocation ?? const LatLng(30.0444, 31.2357);
    _addressController.text = widget.initialAddress;
    _areaController.text = widget.initialArea;
    _additionalInfoController.text = widget.additional;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _areaController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.mainRose,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.grey,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainRose),
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  void _handleConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {
        'location': _selectedLocation,
        'address': _addressController.text,
        'area': _areaController.text,
        'additional': _additionalInfoController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Recipient Address',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: ColorsManager.darkGray,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CompactMapPreview(
                      location: _selectedLocation!,
                      onLocationChanged: (location) async {
                        try {
                          final response = await http.get(Uri.parse(
                            'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=${EnvConfig.mapsApiKey}',
                          ));

                          if (response.statusCode == 200) {
                            final data = json.decode(response.body);
                            if (data['results'] != null &&
                                data['results'].isNotEmpty) {
                              final address = data['results'][0]
                                  ['formatted_address'] as String;
                              String area = '';

                              if (data['results'][0]['address_components'] !=
                                  null) {
                                final components = data['results'][0]
                                    ['address_components'] as List;
                                for (final component in components) {
                                  final types = component['types'] as List;
                                  if (types.contains('neighborhood') ||
                                      types.contains('sublocality') ||
                                      types.contains('sublocality_level_1')) {
                                    area = component['long_name'] as String;
                                    break;
                                  }
                                }
                              }

                              setState(() {
                                _selectedLocation = location;
                                _addressController.text = address;
                                _areaController.text = area;
                              });
                            }
                          }
                        } catch (e) {
                          log('Error getting address: $e');
                        }
                      },
                      height: 120.h,
                      showFullscreenButton: true,
                      borderRadius: 8,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      'Area',
                      'Enter area',
                      _areaController,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      'Address',
                      'Enter address',
                      _addressController,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      'Additional Address Details',
                      'Apartment number, floor, landmark, etc.',
                      _additionalInfoController,
                      isRequired: false,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextButton(
                      buttonText: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: ColorsManager.lightGrey,
                      textStyle: TextStyle(
                        color: ColorsManager.darkGray,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppTextButton(
                      buttonText: 'Confirm',
                      onPressed: _handleConfirm,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
