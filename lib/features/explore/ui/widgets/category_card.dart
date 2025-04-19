import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.imagePath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 165.w,
                  height: 110.h,
                ),
                Positioned.fill(
                  child: Container(
                    color: ColorsManager.black87.withAlpha((0.3 * 255).toInt()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.ebGaramond(
              color: ColorsManager.mainRose,
              fontWeight: FontWeight.w400,
              fontSize: 21.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
