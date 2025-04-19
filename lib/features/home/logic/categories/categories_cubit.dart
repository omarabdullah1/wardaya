import 'dart:developer';

import 'package:wardaya/features/home/data/models/home_category_response.dart';

import '../../../../core/routing/router_imports.dart';
import '../../data/repos/home_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeRepo _homeRepo;
  CategoriesCubit(this._homeRepo) : super(const CategoriesState.initial());

  Future<void> getCategories() async {
    emit(const CategoriesState.loading());
    try {
      final response = await _homeRepo.getHomeCategories();
      response.when(
        success: (HomeCategoryResponse data) {
          log('data: $data');
          log('Successfully received Categories data with ${data.categories.length} items');
          emit(CategoriesState.success(data));
        },
        failure: (error) {
          log('Error fetching Categories data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(CategoriesState.error(
              error.message ?? 'Failed to fetch Categories data'));
        },
      );
    } catch (e, stackTrace) {
      log('Categories unexpected error: $e', stackTrace: stackTrace);
      emit(CategoriesState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
