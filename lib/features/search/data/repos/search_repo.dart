import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../apis/search_service.dart';
import '../models/search_request_body.dart';
import '../models/search_response.dart';

class SearchRepo {
  final SearchService _apiService;

  SearchRepo(this._apiService);

  Future<ApiResult<SearchResponse>> search(
      SearchRequestBody searchRequestBody) async {
    try {
      final response = await _apiService.search(
        searchRequestBody.limit,
        searchRequestBody.page,
        searchRequestBody.category,
        searchRequestBody.subCategory,
        searchRequestBody.search,
        searchRequestBody.brand,
        searchRequestBody.occasion,
        searchRequestBody.color,
        searchRequestBody.recipients,
        searchRequestBody.bundleTypes,
        searchRequestBody.priceRange,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
