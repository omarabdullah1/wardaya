import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_state.dart';

import '../../data/repos/explore_repo.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo _exploreRepo;
  ExploreCubit(this._exploreRepo) : super(const ExploreState.initial());

  Future<void> getMenuItems() async {
    emit(const ExploreState.loading());
    final response = await _exploreRepo.getMenuItems();
    response.when(
      success: (menuItems) {
        emit(ExploreState.success(menuItems));
      },
      failure: (error) {
        emit(ExploreState.failure(error.message ?? "Unknown error"));
      },
    );
  }
}
