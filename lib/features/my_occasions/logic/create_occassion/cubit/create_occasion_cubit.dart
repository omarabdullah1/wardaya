import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../data/models/create_occasion_response.dart';
import '../../../data/repos/my_occasions_repo.dart';
import 'create_occasion_state.dart';

class CreateOccasionCubit extends Cubit<CreateOccasionState> {
  final MyOccasionsRepo _myOccasionsRepo;
  CreateOccasionCubit(this._myOccasionsRepo)
      : super(const CreateOccasionState.initial());

  Future<void> createOccasions(String name, String date) async {
    emit(const CreateOccasionState.loading());
    try {
      final response = await _myOccasionsRepo.createOccasions({
        'name': name,
        'date': date,
      });
      response.when(
        success: (CreateOccasionResponse data) {
          log('Successfully received Create Occasions data');
          emit(CreateOccasionState.success(data));
        },
        failure: (error) {
          log('Error fetching Create Occasions data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(CreateOccasionState.error(
              error.message ?? 'Failed to fetch Create Occasions data'));
        },
      );
    } catch (e, stackTrace) {
      log('Create Occasions unexpected error: $e', stackTrace: stackTrace);
      emit(CreateOccasionState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
