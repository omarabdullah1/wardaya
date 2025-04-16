import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/subscription_home_response.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = _Initial;
  const factory SubscriptionState.loading() = Loading;
  const factory SubscriptionState.success(SubscriptionPlansResponse data) = Success;
  const factory SubscriptionState.error(String message) = Error;
  const factory SubscriptionState.setDeliveryFrequency(String delevery) =
      SetDeliveryFrequency;
  const factory SubscriptionState.setSubscriptionDuration(String duration) =
      SetSubscriptionDuration;
  const factory SubscriptionState.setStartDate(String date) = SetStartDate;
  const factory SubscriptionState.setSelectedDate(String date) =
      SetSelectedDate;
}
