import 'dart:developer';

import 'package:wardaya/features/home/data/repos/home_repo.dart';

import '../../../../core/routing/router_imports.dart';
import '../../data/models/home_gallery_response.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getHomeGallery() async {
    emit(const HomeState.loading());
    try {
      final response = await _homeRepo.getHomeGallery();
      response.when(success: (GalleryResponse data) {
        emit(HomeState.success(data));
      }, failure: (error) {
        emit(HomeState.error(error.message ?? 'Unknown error occurred'));
      });
    } catch (e, stackTrace) {
      log('Home error: $e', stackTrace: stackTrace);
      emit(HomeState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
