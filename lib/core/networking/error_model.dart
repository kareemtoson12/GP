class ApiErrorModel {
  final int? statusCode; // Make this nullable
  final String? message; // Also make message a String? if it can be null

  ApiErrorModel({this.statusCode, this.message});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      statusCode: json['statusCode'] is int ? json['statusCode'] as int : null,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }
}
