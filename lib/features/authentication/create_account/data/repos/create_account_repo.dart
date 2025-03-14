import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../apis/auth_service.dart';
import '../models/create_account_request_body.dart';
import '../models/create_account_response.dart';

class CreateAccountRepo {
  final AuthenticationService _apiService;

  CreateAccountRepo(this._apiService);

  Future<ApiResult<CreateAccountResponse>> createAccount(
      CreateAccountRequestBody createAccountRequestBody) async {
    try {
      final response =
          await _apiService.createAccount(createAccountRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
