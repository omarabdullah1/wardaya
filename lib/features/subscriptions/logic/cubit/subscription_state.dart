import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/subscriptions/data/models/subscription_response.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = _Initial;
  const factory SubscriptionState.loading() = _Loading;
  const factory SubscriptionState.success(SubscriptionResponse data) = _Success;
  const factory SubscriptionState.error(String message) = _Error;
}
