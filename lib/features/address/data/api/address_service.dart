import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/address_request.dart';
import '../models/address_response.dart';
import 'address_api_constants.dart';

part 'address_service.g.dart';

@RestApi(baseUrl: AddressApiConstants.apiBaseUrl)
abstract class AddressService {
  factory AddressService(Dio dio, {ParseErrorLogger? errorLogger}) =
      _AddressService;

  @GET(AddressApiConstants.address)
  Future<List<Address>> getAddresses();

  @POST(AddressApiConstants.address)
  Future<CreateAddressResponse> createAddress(@Body() AddressRequest request);

  @PUT(AddressApiConstants.addressById)
  Future<CreateAddressResponse> updateAddress(
      @Path('id') String id, @Body() AddressRequest request);
}
