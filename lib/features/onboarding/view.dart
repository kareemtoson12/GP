import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/routing/app_routes.dart';
import 'package:whispertales/core/routing/routes.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'dart:math';

class OnboardingScreen extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 500.h,
                width: 500.w,
                child: Image.asset(
                  'assets/images/on1.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  '     A magical place where you can \n           create your own stories',
                  style: AppTextStyles.font22SeconColor,
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _navigateWithFlipAnimation(context);
                  },
                  child: Container(
                    width: 200.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.dg),
                      color: CustomsColros.darkblue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: AppTextStyles.font20SeconColor
                              .copyWith(color: CustomsColros.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateWithFlipAnimation(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) =>
            // Replace with your actual destination widget
            Navigator(
          key: navigatorKey,
          initialRoute: Routes.naivBar,
          onGenerateRoute: AppRoutes().generateRoute,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeInOut;
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          final rotateAnim =
              Tween(begin: -pi / 2, end: 0.0).animate(curvedAnimation);

          final opacityAnim =
              Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);

          return AnimatedBuilder(
            animation: curvedAnimation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY(rotateAnim.value),
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: opacityAnim.value,
                  child: child,
                ),
              );
            },
            child: child,
          );
        },
      ),
    );
  }
}
