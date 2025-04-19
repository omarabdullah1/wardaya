import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_occassions_response.dart';

part 'occassions_state.freezed.dart';

@freezed
class OccassionsState with _$OccassionsState {
  const factory OccassionsState.initial() = _Initial;

  const factory OccassionsState.loading() = Loading;
  const factory OccassionsState.success(List<OccassionsItem> response) =
      Success;
  const factory OccassionsState.error(String message) = Error;
}
