import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/subscriptions/data/repos/subscription_repo.dart';
import 'subscription_duration_state.dart';

class SubscriptionDurationCubit extends Cubit<SubscriptionDurationState> {
  final SubscriptionRepo _subscriptionRepo;

  SubscriptionDurationCubit(this._subscriptionRepo)
      : super(const SubscriptionDurationState.initial());

  String? selectedDuration;

  Future<void> emitGetSubscriptionDurations() async {
    if (isClosed) return; // Prevent operations on closed cubit

    emit(const SubscriptionDurationState.loading());
    try {
      log('Fetching subscription durations');

      final response = await _subscriptionRepo.getSubscriptionDurations();

      if (isClosed) return; // Check again after async operation

      response.when(success: (data) {
        log('Subscription durations fetched successfully');
        emit(SubscriptionDurationState.success(data));
      }, failure: (error) {
        log('Error fetching subscription durations: ${error.message}');
        emit(SubscriptionDurationState.error(
            error.message ?? 'Unknown error occurred'));
      });
    } catch (e) {
      if (isClosed) return; // Check again after exception

      log('Exception in emitGetSubscriptionDurations: $e');
      emit(const SubscriptionDurationState.error(
          'An unexpected error occurred'));
    }
  }

  setSelectedDuration(String value) {
    selectedDuration = value;
    emit(SubscriptionDurationState.setSelectedDuration(value));
  }
}
