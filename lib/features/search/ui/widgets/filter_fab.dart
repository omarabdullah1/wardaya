import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';

class FilterFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: ColorsManager.mainRose,
      foregroundColor: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      label: Row(
        children: [
          const Icon(Icons.filter_list),
          SizedBox(width: 4.0.w),
          Text(
            context.el.filterButton,
            style: GoogleFonts.inter(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
