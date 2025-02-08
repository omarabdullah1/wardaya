import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you're using SVGs for the icons

import 'package:wardaya/core/theming/colors.dart'; // Assuming you use the theme colors

class PastRecordSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final int initialTabIndex;

  const PastRecordSelector({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.initialTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager
            .offWhite, // Replace with your desired background color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem(context, 0, 'Record Video',
              'assets/svgs/video.svg'), // Replace with your icon path
          _buildTabItem(context, 1, 'Past a Link',
              'assets/svgs/link.svg'), // Replace with  your icon path
        ],
      ),
    );
  }

  Widget _buildTabItem(
      BuildContext context, int index, String label, String iconPath) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onTabSelected(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                colorFilter: isSelected
                    ? const ColorFilter.mode(
                        ColorsManager.mainRose, BlendMode.srcIn)
                    : const ColorFilter.mode(
                        ColorsManager.lightLighterGrey, BlendMode.srcIn),
                height: 15.h,
              ),
              SizedBox(width: 5.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? ColorsManager.mainRose
                      : ColorsManager.lighterLightGrey,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
