import 'dart:developer';

import 'package:wardaya/features/my_occasions/data/apis/my_occassions_service.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/my_occasions_response.dart';

class MyOccasionsRepo {
  final MyOccassionsService _apiService;

  MyOccasionsRepo(this._apiService);

  Future<ApiResult<List<MyOccasionItem>>> getMyOccasions() async {
    try {
      final response = await _apiService.getMyOccasions();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getAddresses: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
