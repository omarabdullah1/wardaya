import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/address_response.dart';

part 'recipient_details_state.freezed.dart';

@freezed
class RecipientDetailsState with _$RecipientDetailsState {
  const factory RecipientDetailsState.initial() = _Initial;

  const factory RecipientDetailsState.initialized({
    String? recipientName,
    String? phoneNumber,
    String? area,
    String? address,
    String? extraDetails,
    LatLng? location,
    String? id, // Added ID field for edit operations
  }) = _Initialized;

  const factory RecipientDetailsState.locationUpdated({
    required LatLng location,
    required String address,
    required String area,
  }) = _LocationUpdated;

  const factory RecipientDetailsState.countryCodeUpdated({
    required String countryCode,
  }) = _CountryCodeUpdated;

  // States for address creation
  const factory RecipientDetailsState.loading() = _Loading;

  const factory RecipientDetailsState.success({
    required Address address,
  }) = _Success;

  const factory RecipientDetailsState.error({
    required String error,
  }) = _Error;
}
