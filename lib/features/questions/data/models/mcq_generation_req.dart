class MCQRequest {
  final String story;

  MCQRequest({required this.story});

  Map<String, dynamic> toJson() {
    return {
      'story': story,
    };
  }
}
