import 'dart:developer';

import 'package:wardaya/features/home/data/apis/home_service.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/home_brands_response.dart';
import '../models/home_category_response.dart';
import '../models/home_delivery_areas_response.dart';
import '../models/home_occassions_response.dart';
import '../models/home_recipients_response.dart';

class HomeRepo {
  final HomeService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<List<GalleryItem>>> getHomeGallery() async {
    try {
      final response = await _apiService.getHomeGallery();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getHomeGallery: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<OccassionsItem>>> getHomeOccassions() async {
    try {
      final response = await _apiService.getHomeOccassions();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getHomeOccassions: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<HomeCategoryResponse>> getHomeCategories() async {
    try {
      final response = await _apiService.getHomeCategories();
      final categoryResponse = HomeCategoryResponse(categories: response);
      return ApiResult.success(categoryResponse);
    } catch (error, stackTrace) {
      log('Error in getHomeCategories: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<HomeBrandsResponse>> getHomeBrands() async {
    try {
      final response = await _apiService.getHomeBrands();
      final brandsResponse = HomeBrandsResponse(brands: response);
      return ApiResult.success(brandsResponse);
    } catch (error, stackTrace) {
      log('Error in getHomeBrands: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<Recipient>>> getHomeRecipients() async {
    try {
      final response = await _apiService.getHomeRecipients();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getHomeRecipients: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<DeliveryArea>>> getHomeDeliveryAreas() async {
    try {
      final response = await _apiService.getHomeDeliveryAreas();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getHomeDeliveryAreas: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
