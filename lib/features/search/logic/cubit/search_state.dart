import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.success(SearchResponse response) = _Success;
  const factory SearchState.error(String message) = _Error;
}
