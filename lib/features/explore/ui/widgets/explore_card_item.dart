import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/theming/colors.dart';

class ExploreCardItem extends StatelessWidget {
  final String imagePath;
  final String lable;
  final VoidCallback onTap;

  const ExploreCardItem({
    super.key,
    required this.imagePath,
    required this.lable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 165.w,
        height: 180.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 165.w,
                height: 180.h,
              ),
              Positioned.fill(
                child: Container(
                  color: ColorsManager.black.withAlpha((0.26 * 255).toInt()),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsManager.black87,
                        ColorsManager.transparent,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: Center(
                      child: Text(
                        lable,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
