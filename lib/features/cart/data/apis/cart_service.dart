import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/add_cart_response.dart';
import 'cart_api_constants.dart';

part 'cart_service.g.dart';

@RestApi(baseUrl: CartApiConstants.apiBaseUrl)
abstract class CartService {
  factory CartService(Dio dio) = _CartService;

  @POST(CartApiConstants.cart)
  Future<AddCartResponse> addToCart(
    @Body() Map<String, dynamic> body,
  );
}
