import 'package:wardaya/features/home/data/apis/home_service.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class HomeRepo {
  final HomeService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<GalleryResponse>> getHomeGallery() async {
    try {
      final response = await _apiService.getHomeGallery();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
