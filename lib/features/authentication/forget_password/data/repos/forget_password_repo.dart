import 'dart:developer';

import 'package:wardaya/core/networking/api_error_handler.dart';
import 'package:wardaya/core/networking/api_result.dart';
import 'package:wardaya/features/authentication/apis/auth_service.dart';
import 'package:wardaya/features/authentication/forget_password/data/models/forget_password_request.dart';
import 'package:wardaya/features/authentication/forget_password/data/models/forget_password_response.dart';

class ForgetPasswordRepo {
  final AuthenticationService _apiService;

  ForgetPasswordRepo(this._apiService);

  Future<ApiResult<ForgetPasswordResponse>> forgetPassword(String email) async {
    try {
      final request = ForgetPasswordRequest(email: email);
      final response = await _apiService.forgetPassword(request);
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Forget password error: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
