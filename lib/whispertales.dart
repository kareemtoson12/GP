import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/di/dep_injection.dart';
import 'package:whispertales/core/routing/app_routes.dart';
import 'package:whispertales/core/routing/routes.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/questions/cubit/questions_cubit.dart';

class WhisperTales extends StatelessWidget {
  final AppRoutes appRouter;
  const WhisperTales({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(generateTextRepo: getit())),
        BlocProvider(create: (context) => MCQCubit(generateMcqRepo: getit())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WhisperTales',
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.splash,
        ),
      ),
    );
  }
}
