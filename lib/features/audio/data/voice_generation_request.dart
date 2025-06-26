class VoiceGenerationRequest {
  final String text;
  final String character;
  final int speed;

  const VoiceGenerationRequest({
    required this.text,
    required this.character,
    required this.speed,
  });

  factory VoiceGenerationRequest.fromJson(Map<String, dynamic> json) {
    return VoiceGenerationRequest(
      text: json['text'] as String,
      character: json['character'] as String,
      speed: json['speed'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'character': character,
      'speed': speed,
    };
  }
}
