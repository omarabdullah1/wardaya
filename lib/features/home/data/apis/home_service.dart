import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';
import 'home_api_constants.dart';

part 'home_service.g.dart';

@RestApi(baseUrl: HomeApiConstants.apiBaseUrl)
abstract class HomeService {
  factory HomeService(Dio dio) = _HomeService;

  @GET(HomeApiConstants.gallery)
  Future<GalleryResponse> getHomeGallery();
}
