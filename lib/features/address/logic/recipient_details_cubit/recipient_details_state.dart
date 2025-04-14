import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  }) = _Initialized;

  const factory RecipientDetailsState.locationUpdated({
    required LatLng location,
    required String address,
    required String area,
  }) = _LocationUpdated;
}
