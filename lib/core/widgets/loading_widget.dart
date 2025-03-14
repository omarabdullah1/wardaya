import 'package:custom_loading/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../assets/assets.dart';
import '../theming/colors.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final bool loadingState;
  const LoadingWidget({
    super.key,
    required this.loadingState,
    this.height = 80,
    this.width = 80,
    this.borderRadius = 15,
    this.backgroundColor = ColorsManager.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.h,
      child: CustomLoadingScaffold(
        backgroundColor: ColorsManager.transparent,
        isLoading: loadingState,
        blurIntensity: 2.0,
        loaderWidget: Container(
          height: height.h,
          width: width.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.black.withAlpha(25),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: LottieBuilder.asset(
              Assets.of(context).lottie.loading_animation_json),
        ),
      ),
    );
  }
}
