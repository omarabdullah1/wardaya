import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';

import '../models/add_cart_response.dart';
import '../models/remove_cart_response.dart';
import 'cart_api_constants.dart';

part 'cart_service.g.dart';

@RestApi(baseUrl: CartApiConstants.apiBaseUrl)
abstract class CartService {
  factory CartService(Dio dio) = _CartService;

  @POST(CartApiConstants.cart)
  Future<AddCartResponse> addToCart(
    @Body() Map<String, dynamic> body,
  );
  @GET(CartApiConstants.cart)
  Future<List<GetCartItem>> getCart();

  @DELETE(CartApiConstants.removeFromCart)
  Future<RemoveCartResponse> removeFromCart(
    @Path('productId') String productId,
  );
}
