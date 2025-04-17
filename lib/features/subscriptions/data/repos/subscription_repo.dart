import 'dart:developer';

import 'package:wardaya/features/subscriptions/data/models/subscription_duration_response.dart';

import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../apis/subscription_service.dart';
import '../models/subscription_plans_response.dart';

class SubscriptionRepo {
  final SubscriptionService _apiService;

  SubscriptionRepo(this._apiService);

  Future<ApiResult<List<SubscriptionPlan>>> getSubscriptionPlans() async {
    try {
      final response = await _apiService.getSubcriptionPlans();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      // Log the error and stack trace for debugging
      log('Error fetching subscription plans: $error $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<SubscriptionDuration>>>
      getSubscriptionDurations() async {
    try {
      final response = await _apiService.getSubcriptionDurations();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      // Log the error and stack trace for debugging
      log('Error fetching subscription durations: $error $stackTrace');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
