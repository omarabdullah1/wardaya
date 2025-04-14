import 'dart:developer';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../api/address_service.dart';
import '../models/address_response.dart';

class AddressRepo {
  final AddressService _apiService;

  AddressRepo(this._apiService);

  Future<ApiResult<List<Address>>> getAddresses() async {
    try {
      final response = await _apiService.getAddresses();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getAddresses: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
