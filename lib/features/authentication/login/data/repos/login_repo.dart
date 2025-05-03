import 'dart:developer';

import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../apis/auth_service.dart';
import '../../../models/apple_login_request.dart';
import '../../../models/google_login_request.dart';
import '../models/login_request_body.dart';
import '../models/login_response.dart';

class LoginRepo {
  final AuthenticationService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Login error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginResponse>> loginWithGoogle(
      GoogleLoginRequest googleLoginRequest) async {
    try {
      final response = await _apiService.loginWithGoogle(googleLoginRequest);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Google login error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginResponse>> loginWithApple(
      AppleLoginRequest appleLoginRequest) async {
    try {
      final response = await _apiService.loginWithApple(appleLoginRequest);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Apple login error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
