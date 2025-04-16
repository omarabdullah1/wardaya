import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/address_response.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState.initial() = _Initial;
  const factory AddressState.loading() = _Loading;
  const factory AddressState.success({
    required List<Address> addresses,
  }) = Success;
  const factory AddressState.error({required String error}) = _Error;
}
