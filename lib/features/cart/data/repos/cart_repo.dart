import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wardaya/core/networking/api_error_handler.dart';
import 'package:wardaya/core/networking/api_result.dart';
import 'package:wardaya/features/cart/data/models/add_cart_response.dart';
import 'package:wardaya/features/cart/data/models/checkout_request.dart';
import 'package:wardaya/features/cart/data/models/checkout_response.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/data/models/get_gift_cards_response.dart';
import 'package:wardaya/features/cart/data/models/promo_code_response.dart';
import 'package:wardaya/features/cart/data/models/remove_cart_response.dart';
import 'package:wardaya/features/cart/data/models/upload_video_response.dart';

import '../apis/cart_service.dart';
import '../models/upload_signature_response.dart';

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

  Future<ApiResult<UploadSignatureResponse>> uploadSignature(
      Uint8List imageBytes, String fileName) async {
    try {
      // Get file extension from fileName
      final String extension = fileName.split('.').last.toLowerCase();

      // Create a MultipartFile from the image bytes with proper content type
      final MultipartFile file = MultipartFile.fromBytes(
        imageBytes,
        filename: fileName,
        contentType:
            MediaType('image', extension), // Specify the correct content type
      );

      // Wrap the file in a list as expected by the service
      final dynamic response = await _cartService.uploadSignature([file]);

      // Handle the dynamic response
      if (response is Map<String, dynamic> &&
          response.containsKey('image_url')) {
        // Manually create the UploadSignatureResponse object from the response map
        final uploadResponse =
            UploadSignatureResponse(imageUrl: response['image_url']);
        return ApiResult.success(uploadResponse);
      } else {
        log('Unexpected response format: $response');
        throw Exception('Unexpected response format from server');
      }
    } catch (error, stackTrace) {
      log('Error uploading signature: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UploadVideoResponse>> uploadVideo(
      Uint8List videoBytes, String fileName) async {
    try {
      // Get file extension from fileName
      final String extension = fileName.split('.').last.toLowerCase();

      // Create a MultipartFile from the video bytes with proper content type
      final MultipartFile file = MultipartFile.fromBytes(
        videoBytes,
        filename: fileName,
        contentType:
            MediaType('video', extension), // Specify the correct content type
      );

      // Wrap the file in a list as expected by the service
      final dynamic response = await _cartService.uploadVideo([file]);

      // Handle the dynamic response - log it for debugging
      log('Received upload response: $response');

      if (response is Map<String, dynamic>) {
        // Check for both camelCase (videoUrl) and snake_case (video_url) formats
        final String? videoUrl = response['videoUrl'] ?? response['video_url'];

        if (videoUrl != null) {
          // Manually create the UploadVideoResponse object from the response map
          final uploadResponse = UploadVideoResponse(videoUrl: videoUrl);
          return ApiResult.success(uploadResponse);
        }
      }

      log('Unexpected response format: $response');
      throw Exception('Unexpected response format from server');
    } catch (error, stackTrace) {
      log('Error uploading video: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<GiftCardTemplate>>> getGiftCards() async {
    try {
      final response = await _cartService.getGiftCards();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in get gift cart: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CheckoutResponse>> checkout(CheckoutRequest request) async {
    try {
      final response = await _cartService.checkout(request);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in checkout: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<PromoCodeResponse>> validatePromo(String promo) async {
    try {
      final response = await _cartService.validatePromo({
        'promo_code': promo,
      });

      // Check if this is a "Promo code not found" response
      if (response.message == "Promo code not found") {
        // Return as a special error case with the message from the API
        return ApiResult.failure(ApiErrorHandler.handle(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: response.message,
            message: response.message,
            type: DioExceptionType.badResponse,
            response: Response(
              data: {'message': response.message},
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
          ),
        ));
      }

      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in validatePromo: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
