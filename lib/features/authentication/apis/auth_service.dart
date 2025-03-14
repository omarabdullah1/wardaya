import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/profile/data/models/profile_response.dart';

import '../create_account/data/models/create_account_request_body.dart';
import '../create_account/data/models/create_account_response.dart';
import '../login/data/models/login_request_body.dart';
import '../login/data/models/login_response.dart';
import 'auth_api_constants.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: AuthenticationApiConstants.apiBaseUrl)
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio) = _AuthenticationService;

  @POST(AuthenticationApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(AuthenticationApiConstants.createAccount)
  Future<CreateAccountResponse> createAccount(
    @Body() CreateAccountRequestBody createAccountRequestBody,
  );
  @GET(AuthenticationApiConstants.myProfile)
  Future<ProfileResponse> getProfile();
}
