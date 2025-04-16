import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

class AreaField extends StatelessWidget {
  final TextEditingController areaController;
  const AreaField({super.key, required this.areaController});

  @override
  Widget build(BuildContext context) {
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
        TextField(
          controller: areaController,
          decoration: InputDecoration(
            hintText: 'Enter area or neighborhood',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.grey,
            ),
            filled: true,
            fillColor: ColorsManager.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainRose),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}
