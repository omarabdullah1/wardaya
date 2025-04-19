import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wardaya/features/search/data/models/filter_data_response.dart';

import '../models/search_response.dart';
import 'search_api_constants.dart';

part 'search_service.g.dart';

@RestApi(baseUrl: SearchApiConstants.apiBaseUrl)
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  @GET(SearchApiConstants.search)
  Future<SearchResponse> search(
    @Query("limit") int limit,
    @Query("page") int page,
    @Query("category") String? category,
    @Query("subCategory") String? subCategory,
    @Query("search") String? search,
    @Query("brand") String? brand,
    @Query("occasion") String? occasion,
    @Query("color") String? color,
    @Query("recipients") String? recipients,
    @Query("bundleTypes") String? bundleTypes,
    @Query("priceRange") String? priceRange,
    @Query("subMenuItems") String? subMenuItems,
    @Query("expressDelivery") bool? expressDelivery,
  );
  @GET(SearchApiConstants.productsFilterData)
  Future<FilterDataResponse> productsFilterData(
    @Query("category") String? category,
    @Query("subCategory") String? subCategory,
    @Query("brand") String? brand,
    @Query("occasion") String? occasion,
    @Query("color") String? color,
    @Query("recipients") String? recipients,
    @Query("bundleTypes") String? bundleTypes,
    @Query("priceRange") String? priceRange,
  );
}
