import 'package:wardaya/features/profile/data/models/profile_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../authentication/apis/auth_service.dart';

class ProfileRepo {
  final AuthenticationService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
