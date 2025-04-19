import 'dart:developer';

import 'package:wardaya/core/networking/api_error_handler.dart';
import 'package:wardaya/core/networking/api_result.dart';
import 'package:wardaya/features/cart/data/models/add_cart_response.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/data/models/remove_cart_response.dart';

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

  Future<ApiResult<List<GetCartItem>>> getCart() async {
    try {
      final response = await _cartService.getCart();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in get to cart: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<RemoveCartResponse>> removeFromCart(String productId) async {
    try {
      final response = await _cartService.removeFromCart(productId);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in remove from cart: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
