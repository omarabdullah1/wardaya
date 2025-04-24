import 'dart:developer';

import 'package:wardaya/features/my_occasions/data/apis/my_occassions_service.dart';
import 'package:wardaya/features/my_occasions/data/models/create_occasion_response.dart';

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

  Future<ApiResult<CreateOccasionResponse>> createOccasions(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.createOccasion(body);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in create Addresses: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CreateOccasionResponse>> updateOccasion(
    String id,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _apiService.updateOccasion(id, body);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in update Occasion: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Map<String, dynamic>>> deleteOccasion(String id) async {
    try {
      final response = await _apiService.deleteOccasion(id);

      // Handle the dynamic response
      if (response is Map) {
        return ApiResult.success(Map<String, dynamic>.from(response));
      } else {
        // If the response isn't a Map, create a standard success response
        return const ApiResult.success(
            {'message': 'Occasion deleted successfully'});
      }
    } catch (error, stackTrace) {
      log('Error in delete Occasion: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
