import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whispertales/core/networking/constants.dart';
import 'package:whispertales/core/networking/dio_factory.dart';
import 'package:whispertales/core/networking/voice_services_api.dart';
import 'package:whispertales/core/routing/app_routes.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/audio/data/voice_generation_request.dart';
import 'package:whispertales/features/audio/data/voice_generation_response.dart';

import 'package:whispertales/features/questions/view.dart'; // MCQScreen

class AudioScreen extends StatefulWidget {
  final String story;

  const AudioScreen({super.key, required this.story});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  // Text animation variables:
  late List<String> words;
  int _currentWordIndex = 0;
  Timer? _timer;

  // Audio playback variables:
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioFileResponse? _audioResponse;
  bool isPlaying = false;
  bool _isAudioLoaded = false;

  @override
  void initState() {
    super.initState();
    // Start text animation:
    words = widget.story.split(' ');
    _startWordAnimation();
    // Generate and play voice:
    _generateAndPlayVoice();
  }

  void _startWordAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentWordIndex < words.length - 1) {
        setState(() {
          _currentWordIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _generateAndPlayVoice() async {
    try {
      final dio = DioFactory.getDio();
      final voiceServices = VoiceServices(dio: dio);
      final request = VoiceGenerationRequest(
        text: widget.story,
        character: "main_american_female",
        speed: 1,
      );
      final response = await voiceServices.generateVoice(request);
      setState(() {
        _audioResponse = response;
        _isAudioLoaded = true;
      });
      // Once audio is loaded, automatically play it:
      await _playAudio();
    } catch (e) {
      print("Error generating voice: $e");
    }
  }

  Future<void> _playAudio() async {
    if (_audioResponse == null) return;
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${_audioResponse!.fileName}';
    final file = File(filePath);
    await file.writeAsBytes(_audioResponse!.fileBytes);
    // Use DeviceFileSource to play from the local file:
    await _audioPlayer.play(DeviceFileSource(filePath));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _togglePlayPause() async {
    if (!_isAudioLoaded) return;
    if (isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.resume();
      setState(() {
        isPlaying = true;
      });
    }
  }

  Future<void> _stopAudio() async {
    if (!_isAudioLoaded) return;
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText = words.sublist(0, _currentWordIndex + 1).join(' ');
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0.dg),
            child: Column(
              children: [
                // Back arrow:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.naivBar);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: CustomsColros.secondColor,
                        size: 25.dg,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                // Display image:
                SizedBox(
                  height: 300.h,
                  width: 350.w,
                  child: Image.asset(
                    'assets/images/read2.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // SizedBox(height: 20.h),
                // Audio control icons:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _togglePlayPause,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: CustomsColros.darkblue,
                        size: 70.h,
                      ),
                    ),
                    IconButton(
                      onPressed: _stopAudio,
                      icon: Icon(
                        Icons.stop,
                        size: 70.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Display animated story text:
                Container(
                  padding: EdgeInsets.all(10.dg),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    displayedText,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font30SeconColor,
                  ),
                ),
                SizedBox(height: 40.h),
                // Navigation to Questions Screen:
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MCQScreen(
                          story: widget.story, // Pass the full story text
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 350.w,
                    padding: EdgeInsets.all(10.dg),
                    decoration: BoxDecoration(
                      color: CustomsColros.darkblue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(
                      child: Text(
                        'questions',
                        style: AppTextStyles.font20blackRegular,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
