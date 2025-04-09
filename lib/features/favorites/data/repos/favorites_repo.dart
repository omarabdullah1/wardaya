import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wardaya/features/favorites/data/apis/favorites_service.dart';
import 'package:wardaya/features/favorites/data/models/get_favorites_response.dart';
import 'package:wardaya/features/favorites/data/models/favorites_response_helper.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/add_favorites_response.dart';
import '../models/delete_favorites_response.dart';

class FavoritesRepo {
  final FavoritesService _apiService;

  FavoritesRepo(this._apiService);

  Future<ApiResult<GetFavoritesResponse>> getFavorites() async {
    try {
      final response = await _apiService.getFavorites();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      // Check if the error is a DioException with response data that's a list
      if (error is DioException && error.response?.data != null) {
        try {
          if (error.response!.data is List) {
            final parsedResponse =
                GetFavoritesResponse.fromJsonList(error.response!.data);
            if (parsedResponse.favorites.isNotEmpty) {
              return ApiResult.success(parsedResponse);
            }
          } else if (error.response!.data is Map<String, dynamic>) {
            final parsedResponse =
                FavoritesResponseHelper.parseGetFavoritesResponse(
                    error.response!.data);
            if (parsedResponse.favorites.isNotEmpty) {
              return ApiResult.success(parsedResponse);
            }
          }
        } catch (parseError) {
          log('Error parsing favorites response: $parseError');
        }
      }
      log('Error in getFavorites: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AddFavoritesResponse>> addToFavorites(
      String productId) async {
    try {
      final response =
          await _apiService.addToFavorites({'productId': productId});
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in addToFavorites: $error', stackTrace: stackTrace);

      // Check specifically for "already in favorites" message
      if (error is DioException &&
          error.response?.statusCode == 400 &&
          error.response?.data is Map<String, dynamic>) {
        final errorData = error.response!.data as Map<String, dynamic>;
        if (errorData.containsKey('message') &&
            errorData['message'].toString().contains('already in favorites')) {
          // Create a custom response using the special constructor
          return ApiResult.success(AddFavoritesResponse.withMessage(
            errorData['message'].toString(),
          ));
        }
      }

      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DeleteFavoritesResponse>> deleteFromFavorites(
      String productId) async {
    try {
      final response = await _apiService.deleteFromFavorites(productId);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in deleteFromFavorites: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
