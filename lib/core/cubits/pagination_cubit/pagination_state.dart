import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_state.freezed.dart';

@freezed
class PaginationState with _$PaginationState {
  const factory PaginationState.initial() = _Initial;
}
