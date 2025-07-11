import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 180);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      // addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

/* 
  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${await SharedPrefHelper.getString(SharedPrefKeys.accessToken)}',
    };
  }
 */
  /*  static void setTokenIntoHeaderAfterLogin(String token) {
    token = SharedPrefHelper.getString(SharedPrefKeys.accessToken);
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }
 */
  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody:
            true, // Ensure responseBody is true if you want to see the response.
        error: true,
        compact: false,
        maxWidth: 90,
      ),
    );
  }
}
