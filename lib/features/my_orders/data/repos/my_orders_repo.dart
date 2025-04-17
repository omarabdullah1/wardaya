import 'dart:developer';

import 'package:wardaya/features/my_orders/data/apis/my_orders_service.dart';
import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class MyOrdersRepo {
  final MyOrdersService _apiService;

  MyOrdersRepo(this._apiService);

  Future<ApiResult<MyOrdersResponse>> getMyOrders(
      {int limit = 10, int page = 1, String? search}) async {
    try {
      final response = await _apiService.getMyOrders(
        limit,
        page,
        search,
      );
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      // Log the error and stack trace for debugging
      log('Error fetching orders: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
