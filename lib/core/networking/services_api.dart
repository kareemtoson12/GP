import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:whispertales/core/networking/constants.dart';
import 'package:whispertales/features/home/data/models/generate_story_request.dart';
import 'package:whispertales/features/home/data/models/generate_story_response.dart';

part 'services_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ServicesApi {
  factory ServicesApi(Dio dio, {String baseUrl}) = _ServicesApi;

  //story generation
  @POST(ApiConstants.generateStory)
  Future<ResponsGnerateeModel> generateStory(
      @Body() RequestGnerateModel requestModel);
}
