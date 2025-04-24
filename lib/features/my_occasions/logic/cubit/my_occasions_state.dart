import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/my_occasions_response.dart';

part 'my_occasions_state.freezed.dart';

@freezed
class MyOccasionsState with _$MyOccasionsState {
  const factory MyOccasionsState.initial() = _Initial;
  const factory MyOccasionsState.loading() = Loading;
  const factory MyOccasionsState.success(List<MyOccasionItem> response) =
      Success;
  const factory MyOccasionsState.error(String message) = Error;

  // States for creating and updating occasions
  const factory MyOccasionsState.actionLoading() = ActionLoading;
  const factory MyOccasionsState.actionSuccess(String message,
      {MyOccasionItem? occasion}) = ActionSuccess;
  const factory MyOccasionsState.actionError(String message) = ActionError;
}
