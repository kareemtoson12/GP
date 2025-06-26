import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:whispertales/core/networking/mcq_services_api.dart';
import 'package:whispertales/features/questions/cubit/questions_state.dart';

import 'package:whispertales/features/questions/data/models/mcq_generation_req.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_response.dart';
import 'package:whispertales/features/questions/data/repo/generate_mcq_repo.dart';

class MCQCubit extends Cubit<MCQState> {
  final GenerateMcqRepo generateMcqRepo;

  MCQCubit({required this.generateMcqRepo}) : super(MCQState.initial());

  /// Loads questions from the API using a given story.
  /// If no story is provided, a default test story is used.
  Future<void> loadQuestions([String? story]) async {
    final testStory = story ??
        "The rain fell hard on Gotham’s streets as Batman moved through the shadows. A child's cry led him to an alley where a figure loomed over a trembling boy. Without a word, Batman struck, disarming the thug with swift precision. The man fled, leaving the boy unharmed.";

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final mcqRequest = MCQRequest(story: testStory);
      final apiResult = await generateMcqRepo.generateMcq(mcqRequest);

      apiResult.when(
        success: (mcqListResponse) {
          final questions = mcqListResponse.mcqs; // List<MCQ>
          final selectedAnswers = List<String>.filled(questions.length, '');
          emit(state.copyWith(
            questions: questions,
            selectedAnswers: selectedAnswers,
            currentIndex: 0,
            selectedAnswer: '',
            isLoading: false,
          ));
        },
        failure: (error) {
          emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()));
        },
      );
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  /// Updates the selected answer for the current question.
  void handleAnswerChange(String answer) {
    final newSelectedAnswers = List<String>.from(state.selectedAnswers);
    newSelectedAnswers[state.currentIndex] = answer; // حفظ الإجابة المختارة
    emit(state.copyWith(
      selectedAnswer: answer,
      selectedAnswers: newSelectedAnswers,
    ));
  }

  /// Moves to the next question or calculates the score if at the last question.
  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      emit(state.copyWith(
        currentIndex: state.currentIndex + 1,
        selectedAnswer: state.selectedAnswers[state.currentIndex + 1],
      ));
    } else {
      _calculateScore(); // عند آخر سؤال، احسب النتيجة
    }
  }

  /// Moves to the previous question.
  void prevQuestion() {
    if (state.currentIndex > 0) {
      emit(state.copyWith(
        currentIndex: state.currentIndex - 1,
        selectedAnswer: state.selectedAnswers[state.currentIndex - 1],
      ));
    }
  }

  void _calculateScore() {
    int score = 0;
    for (int i = 0; i < state.questions.length; i++) {
      final selected = state.selectedAnswers[i].trim().toLowerCase();
      final correct = state.questions[i].correctAnswer.trim().toLowerCase();
      if (selected == correct) {
        score++;
      }
    }
    emit(state.copyWith(isCompleted: true, score: score));
  }
}
