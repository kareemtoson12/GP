class ResponsGnerateeModel {
  final String generatedText;

  ResponsGnerateeModel({required this.generatedText});

  factory ResponsGnerateeModel.fromJson(Map<String, dynamic> json) {
    return ResponsGnerateeModel(
      generatedText: json['generated_text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generated_text': generatedText,
    };
  }
}
