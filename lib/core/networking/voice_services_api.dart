import 'package:dio/dio.dart';
import 'package:whispertales/core/networking/constants.dart';
import 'package:whispertales/features/audio/data/voice_generation_request.dart';
import 'package:whispertales/features/audio/data/voice_generation_response.dart';

class VoiceServices {
  final Dio dio;

  VoiceServices({required this.dio});

  /// Calls the voice generation endpoint and returns an AudioFileResponse.
  Future<AudioFileResponse> generateVoice(
      VoiceGenerationRequest requestModel) async {
    try {
      final response = await dio.post<List<int>>(
        ApiConstants.generateVoice, // e.g., "tts"
        data: requestModel.toJson(),
        options: Options(
          responseType: ResponseType.bytes, // Expect raw binary data.
        ),
      );
      return AudioFileResponse.fromBinaryResponse(response);
    } catch (error) {
      rethrow;
    }
  }
}
