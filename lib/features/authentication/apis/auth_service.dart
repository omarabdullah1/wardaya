import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/authentication/forget_password/data/models/forget_password_request.dart';
import 'package:wardaya/features/authentication/forget_password/data/models/forget_password_response.dart';
import 'package:wardaya/features/profile/data/models/profile_response.dart';

import '../create_account/data/models/create_account_request_body.dart';
import '../create_account/data/models/create_account_response.dart';
import '../login/data/models/login_request_body.dart';
import '../login/data/models/login_response.dart';
import '../models/apple_login_request.dart';
import '../models/google_login_request.dart';
import 'auth_api_constants.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: AuthenticationApiConstants.apiBaseUrl)
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio) = _AuthenticationService;

  @POST(AuthenticationApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(AuthenticationApiConstants.loginGoogle)
  Future<LoginResponse> loginWithGoogle(
    @Body() GoogleLoginRequest googleLoginRequest,
  );

  @POST(AuthenticationApiConstants.loginApple)
  Future<LoginResponse> loginWithApple(
    @Body() AppleLoginRequest appleLoginRequest,
  );

  @POST(AuthenticationApiConstants.createAccount)
  Future<CreateAccountResponse> createAccount(
    @Body() CreateAccountRequestBody createAccountRequestBody,
  );

  @POST(AuthenticationApiConstants.forget)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest forgetPasswordRequest,
  );

  @GET(AuthenticationApiConstants.myProfile)
  Future<ProfileResponse> getProfile();
}
