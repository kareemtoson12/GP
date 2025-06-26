import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/questions/cubit/questions_cubit.dart';
import 'package:whispertales/features/questions/cubit/questions_state.dart';

class MCQScreen extends StatefulWidget {
  final String story;

  const MCQScreen({Key? key, required this.story}) : super(key: key);

  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MCQCubit>().loadQuestions(widget.story);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.dg),
          child: BlocBuilder<MCQCubit, MCQState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(state.errorMessage!,
                      style: AppTextStyles.font20GoogleFont),
                );
              }

              if (state.isCompleted) {
                return ScoreScreen(
                    score: state.score, total: state.questions.length);
              }

              final question = state.questions[state.currentIndex];
              double progress =
                  (state.currentIndex + 1) / state.questions.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MCQ', style: AppTextStyles.font20GoogleFont),
                  LinearProgressIndicator(
                    value: progress,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question.question,
                              style: AppTextStyles.font20GoogleFont),
                          const SizedBox(height: 20),
                          ... // Inside the BlocBuilder's Column children:
                          [
                            {'key': 'A', 'text': question.optionA},
                            {'key': 'B', 'text': question.optionB},
                            {'key': 'C', 'text': question.optionC},
                          ].map((option) {
                            return RadioListTile<String>(
                              title: Text(option['text']!,
                                  style: AppTextStyles.font20GoogleFont),
                              value: option['key']!,
                              groupValue: state.selectedAnswer,
                              onChanged: (value) {
                                context
                                    .read<MCQCubit>()
                                    .handleAnswerChange(value!);
                              },
                              activeColor: CustomsColros.darkblue,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.currentIndex > 0)
                          ElevatedButton(
                            onPressed: () =>
                                context.read<MCQCubit>().prevQuestion(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomsColros.darkblue),
                            child: Text('Previous',
                                style: AppTextStyles.font20GoogleFont),
                          ),
                        ElevatedButton(
                          onPressed: state.selectedAnswer.isNotEmpty
                              ? () => context.read<MCQCubit>().nextQuestion()
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomsColros.darkblue),
                          child: Text('Next',
                              style: AppTextStyles.font20GoogleFont),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  final int score;
  final int total;

  const ScoreScreen({Key? key, required this.score, required this.total})
      : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Score: ${widget.score} / ${widget.total}',
                  style: AppTextStyles.font20GoogleFont),
              const SizedBox(height: 20),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
