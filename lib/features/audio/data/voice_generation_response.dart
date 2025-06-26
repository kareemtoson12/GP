import 'dart:typed_data';
import 'package:dio/dio.dart';

class AudioFileResponse {
  final String fileName;
  final String contentType;
  final Uint8List fileBytes;

  AudioFileResponse({
    required this.fileName,
    required this.contentType,
    required this.fileBytes,
  });

  /// Converts a binary Dio response into an AudioFileResponse.
  factory AudioFileResponse.fromBinaryResponse(Response<List<int>> response) {
    // Try to extract the filename from content-disposition header.
    final contentDisposition =
        response.headers.value('content-disposition') ?? '';
    final fileNameMatch =
        RegExp(r'filename[^=]*=(.*)').firstMatch(contentDisposition);
    final fileName = fileNameMatch != null
        ? fileNameMatch.group(1)?.replaceAll('"', '').trim()
        : 'unknown.wav';

    final contentType = response.headers.value('content-type') ?? 'audio/wav';
    final fileBytes = Uint8List.fromList(response.data ?? []);
    return AudioFileResponse(
      fileName: fileName ?? 'unknown.wav',
      contentType: contentType,
      fileBytes: fileBytes,
    );
  }
}
