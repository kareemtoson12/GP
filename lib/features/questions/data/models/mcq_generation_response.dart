class MCQResponse {
  final List<MCQ> mcqs;

  MCQResponse({required this.mcqs});

  factory MCQResponse.fromJson(Map<String, dynamic> json) {
    return MCQResponse(
      mcqs: (json['mcqs'] as List).map((e) => MCQ.fromJson(e)).toList(),
    );
  }
}

class MCQ {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String correctAnswer;

  MCQ({
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.correctAnswer,
  });

  factory MCQ.fromJson(Map<String, dynamic> json) {
    return MCQ(
      question: json['question'],
      optionA: json['A'],
      optionB: json['B'],
      optionC: json['C'],
      correctAnswer: json['correct_answer'],
    );
  }
}
