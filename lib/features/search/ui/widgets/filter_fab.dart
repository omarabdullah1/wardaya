import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/assets/assets.dart';

class FilterFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterFAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 120.w, // Adjust width as needed
        decoration: BoxDecoration(
          color: ColorsManager.mainRose,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Filters', // Replace with your localization logic
                style: GoogleFonts.inter(
                  color: ColorsManager.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0.sp,
                ),
              ),
              const SizedBox(width: 8.0),
              SvgPicture.asset(
                Assets.of(context).svgs.filter_svg,
                colorFilter: const ColorFilter.mode(
                  ColorsManager.white,
                  BlendMode.srcIn,
                ),
                height: 16.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
