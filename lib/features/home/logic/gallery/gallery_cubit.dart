import 'dart:developer';

import '../../../../core/routing/router_imports.dart';
import '../../data/models/home_gallery_response.dart';
import '../../data/repos/home_repo.dart';
import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final HomeRepo _homeRepo;
  GalleryCubit(this._homeRepo) : super(const GalleryState.initial());

  void getHomeGallery() async {
    emit(const GalleryState.loading());
    try {
      final response = await _homeRepo.getHomeGallery();
      response.when(
        success: (GalleryResponse data) {
          emit(GalleryState.success(data));
        },
        failure: (error) {
          emit(GalleryState.error(
              error.message ?? 'Failed to fetch gallery data'));
        },
      );
    } catch (e, stackTrace) {
      log('Gallery unexpected error: $e', stackTrace: stackTrace);
      emit(GalleryState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
