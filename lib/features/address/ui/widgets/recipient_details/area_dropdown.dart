import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

class AreaDropdown extends StatelessWidget {
  final String area;
  final Function(String?) onChanged;

  const AreaDropdown({
    super.key,
    required this.area,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Define available areas
    final List<String> availableAreas = [
      'Zahraa El Maadi',
      'Maadi',
      'New Cairo',
      'Heliopolis',
      'Union Square' // Added the missing area
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkGray,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorsManager.lightGrey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: availableAreas.contains(area) ? area : availableAreas[0],
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: ColorsManager.darkGray,
                size: 30.sp,
              ),
              items: availableAreas.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorsManager.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
