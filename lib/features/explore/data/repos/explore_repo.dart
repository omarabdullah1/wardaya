import 'dart:developer';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../apis/explore_service.dart';
import '../models/menu_items_response.dart';

class ExploreRepo {
  final ExploreService _apiService;

  ExploreRepo(this._apiService);

  Future<ApiResult<List<MenuItem>>> getMenuItems() async {
    try {
      final response = await _apiService.getMenuItems();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getMenuItems: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
