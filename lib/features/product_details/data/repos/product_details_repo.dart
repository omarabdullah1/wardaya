import 'dart:developer';

import 'package:wardaya/core/networking/api_error_handler.dart';
import 'package:wardaya/core/networking/api_result.dart';
import 'package:wardaya/features/product_details/data/apis/product_details_service.dart';
import 'package:wardaya/features/product_details/data/models/product_response.dart';

class ProductDetailsRepo {
  final ProductDetailsService _productDetailsService;

  ProductDetailsRepo({required ProductDetailsService productDetailsService})
      : _productDetailsService = productDetailsService;

  Future<ApiResult<ProductResponse>> getProductById(String productId) async {
    try {
      final response = await _productDetailsService.getProductById(productId);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getProductById: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  // Future<ApiResult<List<ProductResponse>>> getRelatedProducts(
  //     String productId) async {
  //   try {
  //     final response =
  //         await _productDetailsService.getRelatedProducts(productId);
  //     return ApiResult.success(response);
  //   } catch (error, stackTrace) {
  //     log('Error in getRelatedProducts: $error', stackTrace: stackTrace);
  //     return ApiResult.failure(ApiErrorHandler.handle(error));
  //   }
  // }
}
