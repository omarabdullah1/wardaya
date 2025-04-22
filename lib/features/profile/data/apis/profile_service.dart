import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/delete_account_response.dart';
import '../models/update_user_request.dart';
import '../models/update_user_response.dart';
import 'profile_api_constants.dart';

part 'profile_service.g.dart';

@RestApi(baseUrl: ProfileApiConstants.apiBaseUrl)
abstract class ProfileService {
  factory ProfileService(Dio dio) = _ProfileService;

  @DELETE(ProfileApiConstants.delete)
  Future<DeleteAccountResponse> deleteAccount(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ProfileApiConstants.updateUser)
  Future<UpdateUserResponse> updateUser(
    @Body() UpdateUserRequest body,
  );
}
