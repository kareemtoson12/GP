import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whispertales/core/networking/dio_factory.dart';
import 'package:whispertales/core/networking/constants.dart';
import 'package:whispertales/core/networking/voice_services_api.dart';
import 'package:whispertales/features/audio/data/voice_generation_request.dart';
import 'package:whispertales/features/audio/data/voice_generation_response.dart';

import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  bool _isLoading = false;
  AudioFileResponse? _audioResponse;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _generateVoice() async {
    setState(() {
      _isLoading = true;
    });

    // Create a sample voice generation request
    final request = VoiceGenerationRequest(
      text:
          "The rain fell hard on Gotham’s streets as Batman moved through the shadows. A child's cry led him to an alley where a figure loomed over a trembling boy. Without a word, Batman struck, disarming the thug with swift precision. The man fled, leaving the boy unharmed.",
      character: "main_american_female",
      speed: 1,
    );

    try {
      final dio = DioFactory.getDio();
      // You can also set specific options here if needed.
      final voiceServices = VoiceServices(dio: dio);
      final response = await voiceServices.generateVoice(request);
      setState(() {
        _audioResponse = response;
        _isLoading = false;
      });
    } catch (e) {
      print("Error generating voice: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Play audio by saving bytes to a temporary file and playing it.
  Future<void> _playAudio() async {
    if (_audioResponse == null) return;
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${_audioResponse!.fileName}';
    final file = File(filePath);
    await file.writeAsBytes(_audioResponse!.fileBytes);
    await _audioPlayer.play(DeviceFileSource(filePath));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      appBar: AppBar(
        title: const Text("Voice Generation"),
        backgroundColor: CustomsColros.darkblue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _generateVoice,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Generate Voice"),
            ),
            const SizedBox(height: 20),
            if (_audioResponse != null) ...[
              Text(
                "Audio File: ${_audioResponse!.fileName}",
                style: AppTextStyles.font20GoogleFont,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _playAudio,
                child: const Text("Play Audio"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
