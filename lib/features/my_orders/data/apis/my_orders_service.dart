import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';
import 'my_orders_api_constatnts.dart';

part 'my_orders_service.g.dart';

@RestApi(baseUrl: MyOrdersApiConstants.apiBaseUrl)
abstract class MyOrdersService {
  factory MyOrdersService(Dio dio) = _MyOrdersService;

  @GET(MyOrdersApiConstants.orders)
  Future<MyOrdersResponse> getMyOrders(
    @Query("limit") int limit,
    @Query("page") int page,
    @Query("search") String? search,
  );
}
