import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/cart/data/models/checkout_request.dart';
import 'package:wardaya/features/cart/data/models/checkout_response.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/data/models/get_gift_cards_response.dart';
import 'package:wardaya/features/cart/data/models/promo_code_response.dart';

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

  @POST(CartApiConstants.signatureUpload)
  @MultiPart()
  Future<dynamic> uploadSignature(
    @Part() List<MultipartFile> image,
  );

  @POST(CartApiConstants.videoUpload)
  @MultiPart()
  Future<dynamic> uploadVideo(
    @Part() List<MultipartFile> video,
  );

  @GET(CartApiConstants.giftCards)
  Future<List<GiftCardTemplate>> getGiftCards();

  @POST(CartApiConstants.checkout)
  Future<CheckoutResponse> checkout(
    @Body() CheckoutRequest request,
  );
  @POST(CartApiConstants.promoCode)
  Future<PromoCodeResponse> validatePromo(
    @Body() Map<String, dynamic> body,
  );
}
