import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/subscriptions/data/models/subscription_response.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = _Initial;
  const factory SubscriptionState.loading() = Loading;
  const factory SubscriptionState.success(SubscriptionResponse data) = Success;
  const factory SubscriptionState.error(String message) = Error;
  const factory SubscriptionState.setDeliveryFrequency(String delevery) =
      SetDeliveryFrequency;
  const factory SubscriptionState.setSubscriptionDuration(String duration) =
      SetSubscriptionDuration;
  const factory SubscriptionState.setStartDate(String date) = SetStartDate;
  const factory SubscriptionState.setSelectedDate(String date) =
      SetSelectedDate;
}
