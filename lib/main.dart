import 'package:flutter/material.dart';
import 'package:whispertales/core/di/dep_injection.dart';

import 'package:whispertales/core/routing/routes.dart';

import 'package:whispertales/whispertales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();

  runApp(WhisperTales(
    appRouter: AppRoutes(),
  ));
}
 /* 
  final dio = DioFactory.getDio();

  // Log interceptors
  print("Interceptors: ${dio.interceptors}");

  // Create an instance of ApiServices
  final api = MCQServicesApi(dio);

  // Test the API
  try {
    final MCQRequest req = MCQRequest(
        story:
            "The rain fell hard on Gotham’s streets as Batman moved through the shadows. A child’s cry led him to an alley, where a figure loomed over a trembling boy. Without a word, Batman struck, disarming the thug with swift precision. The man fled, leaving the boy unharmed.Batman said the boy was safe now, his voice steady. The boy stared up at him, wide-eyed, and asked if he was an angel.");

    final MCQResponse response = await api.generateMcqQuestions(req);

    print("Response#@#@@#@#@##@##@!@!@!#: $response");
  } catch (e) {
    print("Error: $e");
  } */