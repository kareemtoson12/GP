import 'package:equatable/equatable.dart';
import 'package:whispertales/features/questions/data/models/mcq_generation_response.dart';

class MCQState extends Equatable {
  final List<MCQ> questions;
  final List<String> selectedAnswers;
  final int currentIndex;
  final String selectedAnswer;
  final bool isLoading;
  final bool isCompleted;
  final int score;
  final String? errorMessage;

  const MCQState({
    required this.questions,
    required this.selectedAnswers,
    required this.currentIndex,
    required this.selectedAnswer,
    required this.isLoading,
    required this.isCompleted,
    required this.score,
    this.errorMessage,
  });

  /// Initial state when the quiz starts.
  factory MCQState.initial() {
    return MCQState(
      questions: [],
      selectedAnswers: [],
      currentIndex: 0,
      selectedAnswer: '',
      isLoading: false,
      isCompleted: false,
      score: 0,
      errorMessage: null,
    );
  }

  /// Copy with method to update the state while keeping previous values.
  MCQState copyWith({
    List<MCQ>? questions,
    List<String>? selectedAnswers,
    int? currentIndex,
    String? selectedAnswer,
    bool? isLoading,
    bool? isCompleted,
    int? score,
    String? errorMessage,
  }) {
    return MCQState(
      questions: questions ?? this.questions,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        selectedAnswers,
        currentIndex,
        selectedAnswer,
        isLoading,
        isCompleted,
        score,
        errorMessage,
      ];
}
