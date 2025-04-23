import 'dart:developer';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../api/address_service.dart';
import '../models/address_request.dart';
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

  Future<ApiResult<Address>> createAddress(
      AddressRequest addressRequest) async {
    try {
      final responseWrapper = await _apiService.createAddress(addressRequest);
      return ApiResult.success(responseWrapper.address);
    } catch (error, stackTrace) {
      log('Error in createAddress: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<Address>> updateAddress(
      String addressId, AddressRequest addressRequest) async {
    try {
      final responseWrapper =
          await _apiService.updateAddress(addressId, addressRequest);
      return ApiResult.success(responseWrapper.address);
    } catch (error, stackTrace) {
      log('Error in updateAddress: $error', stackTrace: stackTrace);
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
