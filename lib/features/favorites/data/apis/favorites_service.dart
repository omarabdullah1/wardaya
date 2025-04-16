import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/favorites/data/models/get_favorites_response.dart';

import '../models/add_favorites_response.dart';
import '../models/delete_favorites_response.dart';
import 'favorites_api_constants.dart';

part 'favorites_service.g.dart';

@RestApi(baseUrl: FavoritesApiConstants.apiBaseUrl)
abstract class FavoritesService {
  factory FavoritesService(Dio dio) = _FavoritesService;

  @POST(FavoritesApiConstants.favorites)
  Future<AddFavoritesResponse> addToFavorites(@Body() Map<String, String> body);

  @GET(FavoritesApiConstants.favorites)
  Future<List<GetFavoriteProduct>> getFavorites();

  @DELETE(FavoritesApiConstants.favorites)
  Future<DeleteFavoritesResponse> deleteFromFavorites(
      @Query("productId") String productId);
}
