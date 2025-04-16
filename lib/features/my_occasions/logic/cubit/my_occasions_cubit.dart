import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/my_occasions_response.dart';
import '../../data/repos/my_occasions_repo.dart';
import 'my_occasions_state.dart';

class MyOccasionsCubit extends Cubit<MyOccasionsState> {
  final MyOccasionsRepo _myOccasionsRepo;

  MyOccasionsCubit(this._myOccasionsRepo) : super(const MyOccasionsState.initial());

  Future<void> getMyOccasions() async {
    emit(const MyOccasionsState.loading());
    try {
      final response = await _myOccasionsRepo.getMyOccasions();
      response.when(
        success: (List<MyOccasionItem> data) {
          log('Successfully received My Occasions data with ${data.length} items');
          emit(MyOccasionsState.success(data));
        },
        failure: (error) {
          log('Error fetching My Occasions data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(MyOccasionsState.error(
              error.message ?? 'Failed to fetch My Occasions data'));
        },
      );
    } catch (e, stackTrace) {
      log('My Occasions unexpected error: $e', stackTrace: stackTrace);
      emit(MyOccasionsState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}