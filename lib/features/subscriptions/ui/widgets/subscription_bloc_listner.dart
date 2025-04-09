import 'package:localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/subscriptions/logic/cubit/subscription_cubit.dart';

import '../../../../core/routing/router_imports.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../logic/cubit/subscription_state.dart';
import 'subscription_plan_card.dart';

class SubscriptionBlocListner extends StatelessWidget {
  const SubscriptionBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            return SubscriptionPlanCard(
              title: context.el.addMediaTitle,
              description: context.el.addToMessageButton,
              price: '173',
              currency: 'SAR',
              images: const [
                'assets/images/sub1.png',
                'assets/images/sub2.png',
                'assets/images/sub3.png',
              ],
            );
          },
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingWidget(
                  loadingState: true,
                ),
              );
            });
            return const SizedBox.shrink();
          },
          error: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            return const SizedBox.shrink();
          }, // Error already handled in listener
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
