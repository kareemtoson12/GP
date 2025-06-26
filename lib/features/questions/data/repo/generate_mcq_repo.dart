import 'package:whispertales/core/networking/api_results.dart';
import 'package:whispertales/core/networking/error_handling.dart';
import 'package:whispertales/core/networking/mcq_services_api.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_req.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_response.dart';

class GenerateMcqRepo {
  final MCQServicesApi servicesInstance;

  GenerateMcqRepo(this.servicesInstance);
  Future<ApiResult<MCQResponse>> generateMcq(MCQRequest requestModel) async {
    try {
      final response =
          await servicesInstance.generateMcqQuestions(requestModel);
      return ApiResult.success(response);
    } catch (er) {
      return ApiResult.failure(
        ErrorHandler.handle(er),
      );
    }
  }
}
