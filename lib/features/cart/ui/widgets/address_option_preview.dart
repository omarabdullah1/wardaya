import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/subscriptions/ui/compact_map_preview.dart';
import 'package:wardaya/features/subscriptions/ui/recipient_address_sheet.dart';

class AddressOptionPreview extends StatelessWidget {
  final String text;
  final bool isSelected;
  final LatLng? location;
  final String address;
  final String area;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const AddressOptionPreview({
    super.key,
    required this.text,
    required this.isSelected,
    this.location,
    this.address = '',
    this.area = '',
    required this.groupValue,
    required this.onChanged,
  });

  Future<void> _showEditSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      builder: (context) => RecipientAddressSheet(
        initialLocation: location,
        initialAddress: address,
        initialArea: area,
      ),
    );

    if (result != null) {
      onChanged(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => text == 'Enter recipient address'
          ? _showEditSheet(context)
          : onChanged(text),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color:
                isSelected ? ColorsManager.mainRose : ColorsManager.lightGrey,
          ),
        ),
        child: Column(
          children: [
            RadioListTile(
              value: text,
              groupValue: groupValue,
              onChanged: onChanged,
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? ColorsManager.mainRose
                                : ColorsManager.darkGray,
                          ),
                        ),
                        if (isSelected && location != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            area,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.darkGray,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => text == 'Enter recipient address'
                        ? _showEditSheet(context)
                        : onChanged(text),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: isSelected
                          ? ColorsManager.mainRose
                          : ColorsManager.darkGray,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected && location != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CompactMapPreview(
                      location: location!,
                      onLocationChanged: (_) => _showEditSheet(context),
                      height: 120.h,
                      showFullscreenButton: false,
                      borderRadius: 8,
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
