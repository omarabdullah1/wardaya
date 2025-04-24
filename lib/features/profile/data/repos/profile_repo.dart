import 'package:wardaya/features/profile/data/apis/profile_service.dart';
import 'package:wardaya/features/profile/data/models/profile_response.dart';
import 'package:wardaya/features/profile/data/models/update_user_request.dart';
import 'package:wardaya/features/profile/data/models/update_user_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../authentication/apis/auth_service.dart';
import '../models/delete_account_response.dart';

class ProfileRepo {
  final AuthenticationService _apiService;
  final ProfileService _profileService;

  ProfileRepo(this._apiService, this._profileService);

  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DeleteAccountResponse>> deleteAccount(
    String id,
  ) async {
    try {
      final response = await _profileService.deleteAccount({
        "userIds": [id],
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UpdateUserResponse>> updateUser({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? countryCode,
  }) async {
    try {
      final response = await _profileService.updateUser(
        UpdateUserRequest(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          countryCode: countryCode,
        ),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
