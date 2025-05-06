import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/subscriptions/ui/widgets/subscription_banner.dart';
import 'package:wardaya/features/subscriptions/ui/widgets/subscription_how_it_works_section.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/routing/router_imports.dart';
import '../../../core/theming/styles.dart';
import '../logic/plans/subscription_cubit.dart';
import 'widgets/plans_builder.dart';

class SusbcriptionsScreen extends StatelessWidget {
  const SusbcriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizedPlans = context.el.subscriptionPlans;

    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorsManager.transparent,
        elevation: 0,
        titleSpacing: 20,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
            size: 18.0.h,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Add your refresh logic here
          context.read<SubscriptionCubit>().emitGetSubscription();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubscriptionBanner(),
              const VerticalSpace(height: 20),
              const SubscriptionHowItWorksSection(),
              const VerticalSpace(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  localizedPlans,
                  style: TextStylesEBGaramond.font32MainRoseRegular,
                ),
              ),
              const PlansBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
