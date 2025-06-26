class RequestGnerateModel {
  final String genre;
  final String prompt;
  final int targetLength;
  final int maxLength;

  RequestGnerateModel({
    required this.genre,
    required this.prompt,
    required this.targetLength,
    required this.maxLength,
  });
//to json
  Map<String, dynamic> toJson() {
    return {
      'genre': genre,
      'prompt': prompt,
      'target_length': targetLength,
      'max_length': maxLength,
    };
  }
}
