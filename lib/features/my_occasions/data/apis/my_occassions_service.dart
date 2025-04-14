import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/my_occasions_response.dart';
import 'my_occassions_api_constatnts.dart';


part 'my_occassions_service.g.dart';

@RestApi(baseUrl: MyOccasionsApiConstants.apiBaseUrl)
abstract class MyOccassionsService {
  factory MyOccassionsService(Dio dio) = _MyOccassionsService;

  @GET(MyOccasionsApiConstants.useroccasions)
  Future<List<MyOccasionItem>> getMyOccasions();
}
