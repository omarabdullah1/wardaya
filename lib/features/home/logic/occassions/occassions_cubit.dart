import 'dart:developer';

import '../../../../core/routing/router_imports.dart';
import '../../data/models/home_occassions_response.dart';
import '../../data/repos/home_repo.dart';
import 'occassions_state.dart';

class OccassionsCubit extends Cubit<OccassionsState> {
  final HomeRepo _homeRepo;

  OccassionsCubit(this._homeRepo) : super(const OccassionsState.initial());

  void getHomeOccassions() async {
    emit(const OccassionsState.loading());
    try {
      final response = await _homeRepo.getHomeOccassions();
      response.when(
        success: (List<OccassionsItem> data) {
          emit(OccassionsState.success(data));
        },
        failure: (error) {
          emit(OccassionsState.error(
              error.message ?? 'Failed to fetch gallery data'));
        },
      );
    } catch (e, stackTrace) {
      log('Gallery unexpected error: $e', stackTrace: stackTrace);
      emit(OccassionsState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
