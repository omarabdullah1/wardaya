import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/home/data/models/home_brands_response.dart';
import 'package:wardaya/features/home/data/repos/home_repo.dart';
import 'package:wardaya/features/home/logic/brands/brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final HomeRepo _homeRepo;
  BrandsCubit(this._homeRepo) : super(const BrandsState.initial());

  void getBrands() async {
    emit(const BrandsState.loading());
    try {
      final response = await _homeRepo.getHomeBrands();
      response.when(
        success: (HomeBrandsResponse data) {
          log('data: $data');
          log('Successfully received Brands data with ${data.brands.length} items');
          emit(BrandsState.success(data));
        },
        failure: (error) {
          log('Error fetching Brands data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(BrandsState.error(
              error.message ?? 'Failed to fetch Brands data'));
        },
      );
    } catch (e, stackTrace) {
      log('Brands unexpected error: $e', stackTrace: stackTrace);
      emit(BrandsState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
