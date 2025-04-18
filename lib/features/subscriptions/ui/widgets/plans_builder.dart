import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/subscriptions/data/models/subscription_plans_response.dart';
import 'package:wardaya/features/subscriptions/logic/plans/subscription_cubit.dart';
import 'package:wardaya/features/subscriptions/logic/plans/subscription_state.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/loading_widget.dart';
import 'subscription_plan_card.dart';

class PlansBuilder extends StatelessWidget {
  const PlansBuilder({super.key});

  void setupErrorState(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: TextStyles.font22MainRoseSemiBold,
        ),
        backgroundColor: ColorsManager.red,
      ),
    );
  }

  Widget _setupLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(
          loadingState: true,
        ),
      );
    });

    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SubscriptionPlanCard(
              planId: '',
              title: 'Loading plan...',
              description: 'Loading description...',
              price: '000',
              currency: 'SAR',
              images: [
                'assets/images/sub2.png',
                'assets/images/sub1.png',
                'assets/images/sub3.png',
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _setupSuccess(BuildContext context, List<SubscriptionPlan> plans) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.canPop(context)) {
        context.pop();
      }
    });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SubscriptionPlanCard(
            planId: plan.id,
            title: plan.name,
            description: plan.miniDescription,
            price: plan.pricePerDelivery.toString(),
            currency: plan.products.isNullOrEmpty()
                ? 'SAR'
                : plan.products.first.price.currency,
            images: plan.imagesUrl,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionCubit, SubscriptionState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
              setupErrorState(context, error);
            });
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          loading: () => _setupLoading(context),
          success: (data) => _setupSuccess(context, data),
          error: (_) => const SizedBox.shrink(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
