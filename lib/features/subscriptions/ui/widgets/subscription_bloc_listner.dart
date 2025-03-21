import 'package:localization/localization.dart';
import 'package:wardaya/features/subscriptions/logic/cubit/subscription_cubit.dart';

import '../../../../core/routing/router_imports.dart';
import '../../logic/cubit/subscription_state.dart';
import 'subscription_plan_card.dart';

class SubscriptionBlocListner extends StatelessWidget {
  const SubscriptionBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final widget = state.whenOrNull(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (data) {
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
          error: (message) {
            return Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
        return widget ?? const SizedBox.shrink();
      },
    );
  }
}
