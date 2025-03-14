import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/subscriptions/ui/widgets/subscription_banner.dart';
import 'package:wardaya/features/subscriptions/ui/widgets/subscription_how_it_works_section.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/routing/router_imports.dart';
import '../../../core/theming/styles.dart';
import 'widgets/subscription_plan_card.dart';

class SusbcriptionsScreen extends StatelessWidget {
  const SusbcriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.transparent,
        elevation: 0,
        titleSpacing: 20,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 28.sp,
            color: ColorsManager.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubscriptionBanner(),
            verticalSpace(20),
            const SubscriptionHowItWorksSection(),
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                context.el.subscriptionPlans,
                style: TextStylesEBGaramond.font32MainRoseRegular,
              ),
            ),
            verticalSpace(20),
            SubscriptionPlanCard(
              title: context.el.addMediaTitle,
              description: context.el.subscriptionDescription,
              price: '173',
              currency: 'SAR',
              images: const [
                'assets/images/sub1.png',
                'assets/images/sub2.png',
                'assets/images/sub3.png',
              ],
            ),
            verticalSpace(20),
            SubscriptionPlanCard(
              title: context.el.addMediaTitle,
              description: context.el.subscriptionDescription,
              price: '173',
              currency: 'SAR',
              images: const [
                'assets/images/sub2.png',
                'assets/images/sub1.png',
                'assets/images/sub3.png',
              ],
            ),
            verticalSpace(20),
            SubscriptionPlanCard(
              title: context.el.addMediaTitle,
              description: context.el.subscriptionDescription,
              price: '173',
              currency: 'SAR',
              images: const [
                'assets/images/sub3.png',
                'assets/images/sub2.png',
                'assets/images/sub1.png',
              ],
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
