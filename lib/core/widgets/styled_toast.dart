import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class StyledToastWidget extends StatelessWidget {
  const StyledToastWidget({
    super.key,
    required this.message,
    required this.icon,
    required this.color,
  });
  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: context.pOW(80.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStylesInter.font12WhiteBold,
                ),
              ),
              Icon(
                icon,
                color: ColorsManager.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
