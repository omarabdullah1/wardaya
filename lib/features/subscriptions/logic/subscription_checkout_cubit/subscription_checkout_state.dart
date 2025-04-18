import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/features/subscriptions/data/models/subscription_checkout_response.dart';

part 'subscription_checkout_state.freezed.dart';

@freezed
class SubscriptionCheckoutState with _$SubscriptionCheckoutState {
  const factory SubscriptionCheckoutState.initial() = _Initial;

  const factory SubscriptionCheckoutState.recipientSelected({
    required String recipientName,
    required String phoneNumber,
  }) = _RecipientSelected;

  const factory SubscriptionCheckoutState.locationSelected({
    required LatLng location,
    required String address,
    required String area,
    required String additionalInfo,
  }) = _LocationSelected;

  const factory SubscriptionCheckoutState.loading() = Loading;
  const factory SubscriptionCheckoutState.loaded(
      SubscriptionCheckoutResponse response) = Loaded;

  const factory SubscriptionCheckoutState.error({
    required String message,
  }) = _Error;
}
