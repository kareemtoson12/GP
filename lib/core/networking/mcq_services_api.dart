import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:whispertales/core/networking/constants.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_req.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_response.dart';

part 'mcq_services_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrlforMcq)
abstract class MCQServicesApi {
  factory MCQServicesApi(Dio dio, {String baseUrl}) = _MCQServicesApi;

  @POST(ApiConstants.generateMcqQuestions)
  Future<MCQResponse> generateMcqQuestions(
    @Body() MCQRequest request,
  );
}
