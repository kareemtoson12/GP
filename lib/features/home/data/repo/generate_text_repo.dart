import 'package:whispertales/core/networking/api_results.dart';
import 'package:whispertales/core/networking/error_handling.dart';
import 'package:whispertales/core/networking/services_api.dart';
import 'package:whispertales/features/home/data/models/generate_story_request.dart';
import 'package:whispertales/features/home/data/models/generate_story_response.dart';

class GenerateTextRepo {
  final ServicesApi servicesInstance;

  GenerateTextRepo(this.servicesInstance);

  Future<ApiResult<ResponsGnerateeModel>> generateText(
      RequestGnerateModel requestModel) async {
    try {
      final response = await servicesInstance.generateStory(requestModel);
      return ApiResult.success(response);
    } catch (er) {
      return ApiResult.failure(
        ErrorHandler.handle(er),
      );
    }
  }
}
