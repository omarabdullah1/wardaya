import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/features/cart/data/models/checkout_response.dart';

part 'checkout_state.freezed.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;

  const factory CheckoutState.recipientSelected({
    required String recipientName,
    required String phoneNumber,
  }) = _RecipientSelected;

  const factory CheckoutState.locationSelected({
    required LatLng location,
    required String address,
    required String area,
    required String additionalInfo,
  }) = _LocationSelected;

  const factory CheckoutState.loading() = Loading;
  const factory CheckoutState.loaded(CheckoutResponse response) = Loaded;

  const factory CheckoutState.error({
    required String message,
  }) = _Error;

  const factory CheckoutState.deliveryTimeSelected({
    required String date,
    required DateTime dateTime,
    // required String time,
  }) = _DeliveryTimeSelected;
}
