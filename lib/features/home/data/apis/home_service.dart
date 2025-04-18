import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';
import '../models/home_brands_response.dart';
import '../models/home_category_response.dart';
import '../models/home_delivery_areas_response.dart';
import '../models/home_occassions_response.dart';
import '../models/home_recipients_response.dart';
import '../models/home_update_city_response.dart';
import 'home_api_constants.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: HomeApiConstants.apiBaseUrl)
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET(HomeApiConstants.gallery)
  Future<List<GalleryItem>> getHomeGallery();

  @GET(HomeApiConstants.occassions)
  Future<List<OccassionsItem>> getHomeOccassions();

  @GET(HomeApiConstants.categories)
  Future<List<Category>> getHomeCategories();

  @GET(HomeApiConstants.brands)
  Future<List<Brand>> getHomeBrands();

  @GET(HomeApiConstants.recipients)
  Future<List<Recipient>> getHomeRecipients();

  @GET(HomeApiConstants.deliveryAreas)
  Future<List<DeliveryArea>> getHomeDeliveryAreas();

  @PUT(HomeApiConstants.editUser)
  Future<HomeUpdateCityResponse> updateUserCity(
    @Body() Map<String, dynamic> body,
  );
}
