import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = Initial;
  const factory SearchState.loading() = Loading;
  const factory SearchState.success(SearchResponse response) = Success;
  const factory SearchState.error(String message) = Error;
  const factory SearchState.setIsGridView(bool isGrid) = SetIsGridView;
  const factory SearchState.applyFilters(Map<String, String?> filters) =
      ApplyFilters;
  const factory SearchState.setTempFilters(Map<String, String?> filters) =
      SetTempFilters;
  const factory SearchState.setTempFiltersTypeValue(
      String type, String? value) = SetTempFiltersTypeValue;
}
