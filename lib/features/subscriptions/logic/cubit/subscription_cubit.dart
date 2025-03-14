import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/subscriptions/data/repos/subscription_repo.dart';
import '../../../../core/routing/router_imports.dart';
import 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepo _subscriptionRepo;

  SubscriptionCubit(this._subscriptionRepo)
      : super(const SubscriptionState.initial());

  Future<void> emitGetSubscription() async {
    try {
      log('Fetching subscription plans');
      emit(const SubscriptionState.loading());

      final response = await _subscriptionRepo.getSubscriptionPlans();

      response.when(success: (data) {
        log('Subscription plans fetched successfully');
        emit(SubscriptionState.success(data));
      }, failure: (error) {
        log('Error fetching subscription plans: ${error.message}');
        emit(
            SubscriptionState.error(error.message ?? 'Unknown error occurred'));
      });
    } catch (e) {
      log('Exception in emitGetSubscription: $e');
      emit(const SubscriptionState.error('An unexpected error occurred'));
    }
  }
}
