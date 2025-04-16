import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../apis/subscription_service.dart';
import '../models/subscription_home_response.dart';

class SubscriptionRepo {
  final SubscriptionService _apiService;

  SubscriptionRepo(this._apiService);

  Future<ApiResult<SubscriptionPlansResponse>> getSubscriptionPlans() async {
    try {
      final response = await _apiService.getSubcriptionPlan();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
