import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theming/styles.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430.h,
      child: Stack(
        children: [
          // Page View for Images
          Image.asset(
            height: 430.h,
            Assets.of(context).images.subscriptions_banner_png,
            fit: BoxFit.cover,
          ),

          // Page Indicator positioned over the image
          Positioned(
              bottom: 30.h, // Adjust position as needed
              left: 0,
              right: 0,
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: context.el.wardayaSubscriptions,
                  style: TextStylesEBGaramond.font50WhiteRegular,
                  children: [
                    TextSpan(
                      text: '\n${context.el.subscriptionDescription}',
                      style: TextStylesEBGaramond.font23WhiteRegular,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
