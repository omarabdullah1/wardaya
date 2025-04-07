import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/home_recipients_response.dart';
import '../../data/repos/home_repo.dart';
import 'recipients_state.dart';

class RecipientsCubit extends Cubit<RecipientsState> {
  final HomeRepo _homeRepo;
  RecipientsCubit(this._homeRepo) : super(const RecipientsState.initial());

  Future<void> getRecipients() async {
    emit(const RecipientsState.loading());
    try {
      final response = await _homeRepo.getHomeRecipients();
      response.when(
        success: (List<Recipient> data) {
          log('data: $data');
          log('Successfully received Recipients data with ${data.length} items');
          emit(RecipientsState.success(data));
        },
        failure: (error) {
          log('Error fetching Recipients data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(RecipientsState.error(
              error.message ?? 'Failed to fetch Recipients data'));
        },
      );
    } catch (e, stackTrace) {
      log('Recipients unexpected error: $e', stackTrace: stackTrace);
      emit(RecipientsState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
