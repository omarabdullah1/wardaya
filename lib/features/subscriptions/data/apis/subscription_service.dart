import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/subscriptions/data/apis/subscription_api_constants.dart';

import '../models/subscription_duration_response.dart';
import '../models/subscription_plans_response.dart';

part 'subscription_service.g.dart';

@RestApi(baseUrl: SubscriptionApiConstants.apiBaseUrl)
abstract class SubscriptionService {
  factory SubscriptionService(Dio dio) = _SubscriptionService;

  @GET(SubscriptionApiConstants.subscriptionPlan)
  Future<List<SubscriptionPlan>> getSubcriptionPlans();

  @GET(SubscriptionApiConstants.durations)
  Future<List<SubscriptionDuration>> getSubcriptionDurations();
}
