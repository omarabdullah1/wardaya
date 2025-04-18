import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repo.dart';
import 'new_ideas_state.dart';

class NewIdeasCubit extends Cubit<NewIdeasState> {
  final HomeRepo _homeRepo;
  NewIdeasCubit(this._homeRepo) : super(const NewIdeasState.initial());

  Future<void> getHomeNewIdeas() async {
    emit(const NewIdeasState.loading());
    try {
      final response = await _homeRepo.getHomeNewIdeas();
      response.when(
        success: (data) {
          log('Successfully received New Ideas data with ${data.length} items');
          emit(NewIdeasState.success(data));
        },
        failure: (error) {
          log('Error fetching New Ideas data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(NewIdeasState.error(
              error.message ?? 'Failed to fetch New Ideas data'));
        },
      );
    } catch (e, stackTrace) {
      log('New Ideas unexpected error: $e', stackTrace: stackTrace);
      emit(
          NewIdeasState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
