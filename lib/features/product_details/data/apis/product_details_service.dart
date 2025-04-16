import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/product_details/data/apis/product_details_api_constants.dart';
import 'package:wardaya/features/product_details/data/models/product_response.dart';

part 'product_details_service.g.dart';

@RestApi(baseUrl: ProductDetailsApiConstants.apiBaseUrl)
abstract class ProductDetailsService {
  factory ProductDetailsService(Dio dio) = _ProductDetailsService;

  @GET("api/products/{productId}")
  Future<ProductResponse> getProductById(
    @Path("productId") String productId,
  );

  // @GET("api/products/related/{productId}")
  // Future<List<ProductResponse>> getRelatedProducts(
  //   @Path("productId") String productId,
  // );
}
