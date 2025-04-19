import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/create_occasion_response.dart';

part 'create_occasion_state.freezed.dart';

@freezed
class CreateOccasionState with _$CreateOccasionState {
  const factory CreateOccasionState.initial() = _Initial;
  const factory CreateOccasionState.loading() = Loading;
  const factory CreateOccasionState.success(CreateOccasionResponse response) =
      Success;
  const factory CreateOccasionState.error(String message) = Error;
}
