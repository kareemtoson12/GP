import 'package:flutter/material.dart';

import 'package:whispertales/features/audio/view.dart';

import 'package:whispertales/features/home/view.dart';
import 'package:whispertales/features/naivBar/naiv_bar.dart';

import 'package:whispertales/features/splash/view.dart';
import 'package:whispertales/core/routing/app_routes.dart';

import '../../features/onboarding/view.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings screen) {
    // Changed from gnerateRoute to generateRoute
    switch (screen.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.naivBar:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());
      case Routes.audioScreen:
        return MaterialPageRoute(
            builder: (context) => AudioScreen(
                  story:
                      "The old manor stood silent under the moonlight. Detective Harris pushed open the creaking door, the air thick with iron. Lady Evelyn lay sprawled on the velvet rug, a crimson pool forming beneath her. A shattered wine glass rested near her pale fingers. Footsteps echoed behind him.",
                ));
      /* case Routes.questionScreen:
        return MaterialPageRoute(builder: (context) => const MCQScreen()); */
      default:
        return null;
    }
  }
}
