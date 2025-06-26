class ApiConstants {
  //Story Generated
  static const String baseUrl = "https://e955-34-125-66-131.ngrok-free.app/";
  static const String generateStory = "generate";
  //MCQ Generated
  static const String baseUrlforMcq =
      "https://18a4-34-143-202-221.ngrok-free.app/";
  static const String generateMcqQuestions = "generate-mcqs";
  //voice gneration
/*   static const String baseUrlforVoice =
      "https://1fee-34-73-31-140.ngrok-free.app/"; */
  static const String generateVoice =
      "https://9445-35-198-206-249.ngrok-free.app/tts";
}

class ApiErrors {
  static const String badRequestError = "رقم الهاتف مستخدم بالفعل";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError =
      "يوجد خطأ في رقم الهاتف أو كلمة المرور";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
