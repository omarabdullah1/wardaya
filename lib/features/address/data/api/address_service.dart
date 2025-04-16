import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/address_response.dart';
import 'address_api_constants.dart';

part 'address_service.g.dart';

@RestApi(baseUrl: AddressApiConstants.apiBaseUrl)
abstract class AddressService {
  factory AddressService(Dio dio) = _AddressService;

  @GET(AddressApiConstants.address)
  Future<List<Address>> getAddresses();
}
