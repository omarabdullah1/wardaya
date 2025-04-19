import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_category_response.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = Loading;
  const factory CategoriesState.success(HomeCategoryResponse response) =
      Success;
  const factory CategoriesState.error(String message) = Error;
}
