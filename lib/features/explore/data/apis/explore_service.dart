import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/explore/data/models/menu_items_response.dart';
import 'explore_api_constants.dart';

part 'explore_service.g.dart';

@RestApi(baseUrl: ExploreApiConstants.apiBaseUrl)
abstract class ExploreService {
  factory ExploreService(Dio dio) = _ExploreService;

  @GET(ExploreApiConstants.menuitems)
  Future<MenuItemsResponse> getMenuItems();
}
