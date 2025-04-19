import 'dart:developer';

import 'package:wardaya/core/networking/api_error_handler.dart';
import 'package:wardaya/core/networking/api_result.dart';
import 'package:wardaya/features/cart/data/models/add_cart_response.dart';

import '../apis/cart_service.dart';

class CartRepo {
  final CartService _cartService;

  CartRepo(CartService cartService) : _cartService = cartService;

  Future<ApiResult<AddCartResponse>> addToCart(
      Map<String, dynamic> body) async {
    try {
      final response = await _cartService.addToCart(body);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in add to cart: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
