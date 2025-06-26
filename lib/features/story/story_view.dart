import 'package:flutter/material.dart';
import 'dart:async';

class StoryScreen extends StatefulWidget {
  final String story;

  const StoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late List<String> words;
  int _currentWordIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    words = widget.story.split(' ');
    _startWordAnimation();
  }

  void _startWordAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentWordIndex < words.length - 1) {
        setState(() => _currentWordIndex++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText = words.sublist(0, _currentWordIndex + 1).join(' ');

    return Scaffold(
      appBar: AppBar(title: const Text('Your Generated Story')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(displayedText, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
