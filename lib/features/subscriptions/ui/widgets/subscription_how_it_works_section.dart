import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class SubscriptionHowItWorksSection extends StatelessWidget {
  const SubscriptionHowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            context.el.subscriptionHowItWorks,
            style: TextStylesEBGaramond.font32MainRoseRegular,
          ),
        ),
        verticalSpace(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: _buildHowItWorksItem(
                    title: context.el.subscriptionSelectYourPlan,
                    description: context.el.subscriptionChooseWhatFitsYourNeeds,
                    icon: Assets.of(context).svgs.select_plan_svg,
                    context: context,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: _buildHowItWorksItem(
                    title: context.el.subscriptionCustomizeDelivery,
                    description:
                        context.el.subscriptionSetDeliveryFrequencyAndPayment,
                    icon: Assets.of(context).svgs.customize_delivery_svg,
                    context: context,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: _buildHowItWorksItem(
                    title: context.el.subscriptionEnjoyFreshFlowers,
                    description:
                        context.el.subscriptionReceiveFreshFlowersEveryTime,
                    icon: Assets.of(context).svgs.select_plan_svg,
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorksItem({
    required String title,
    required String description,
    required String icon,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.mainRose.withAlpha((0.1 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                icon,
                height: 30.h,
                colorFilter: const ColorFilter.mode(
                  ColorsManager.mainRose,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStylesInter.font17MainRoseBold,
              ),
              verticalSpace(10),
              Text(
                description,
                style: TextStylesInter.font13BlackRegular,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
