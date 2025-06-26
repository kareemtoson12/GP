import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:whispertales/core/networking/dio_factory.dart';
import 'package:whispertales/core/networking/mcq_services_api.dart';
import 'package:whispertales/core/networking/services_api.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/data/repo/generate_text_repo.dart';
import 'package:whispertales/features/questions/cubit/questions_cubit.dart';
import 'package:whispertales/features/questions/data/repo/generate_mcq_repo.dart';

final getit = GetIt.instance;
Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();
  getit.registerLazySingleton<ServicesApi>(() => ServicesApi(dio));
  //generate text
  getit
      .registerLazySingleton<GenerateTextRepo>(() => GenerateTextRepo(getit()));

  getit.registerFactory<HomeCubit>(() => HomeCubit(generateTextRepo: getit()));
  //generate mcq for story
  getit.registerLazySingleton<MCQServicesApi>(() => MCQServicesApi(dio));
  getit.registerLazySingleton<GenerateMcqRepo>(() => GenerateMcqRepo(getit()));

  getit.registerFactory<MCQCubit>(() => MCQCubit(generateMcqRepo: getit()));
}
