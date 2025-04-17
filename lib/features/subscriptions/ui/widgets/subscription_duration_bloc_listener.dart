import 'package:wardaya/features/subscriptions/logic/durations/subscription_duration_cubit.dart';

import '../../../../core/routing/router_imports.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../logic/durations/subscription_duration_state.dart';
import 'build_radio_list.dart';

class SubscriptionDurationBlocListener extends StatelessWidget {
  const SubscriptionDurationBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionDurationCubit, SubscriptionDurationState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
            // You might need to create a SubscriptionDurationCard widget
            // or modify this to use an existing widget
            return BuildSubscriptionRadioList(
              options: data.map((duration) => duration.duration).toList(),
              deliveries: data
                  .map((duration) => '${duration.duration} delivery')
                  .toList(),
              prices: data
                  .map((duration) => 'SAR ${duration.discountedPrice}')
                  .toList(),
              optionsOffValue: data
                  .map((duration) =>
                      ((1 - (duration.discountedPrice / duration.price)) * 100)
                          .toStringAsFixed(0))
                  .toList(),
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
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
