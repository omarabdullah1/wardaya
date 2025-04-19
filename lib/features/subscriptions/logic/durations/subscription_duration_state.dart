import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/subscription_duration_response.dart';

part 'subscription_duration_state.freezed.dart';

@freezed
class SubscriptionDurationState with _$SubscriptionDurationState {
  const factory SubscriptionDurationState.initial() = _Initial;
  const factory SubscriptionDurationState.loading() = _Loading;
  const factory SubscriptionDurationState.success(
      List<SubscriptionDuration> data) = _Success;
  const factory SubscriptionDurationState.error(String message) = _Error;
  const factory SubscriptionDurationState.setSelectedDuration(String value) =
      _SetSelectedDuration;
}
