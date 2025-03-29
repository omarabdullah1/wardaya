import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;
  static String? _currentLanguage;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      // Apply language if it was set before dio initialization
      if (_currentLanguage != null) {
        setLanguageParameter(_currentLanguage!);
      }
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  static void setLanguageParameter(String language) {
    _currentLanguage = language;

    // If dio isn't initialized yet, we'll apply this when it is
    if (dio == null) return;

    // Remove any existing language interceptor
    dio?.interceptors
        .removeWhere((interceptor) => interceptor is LanguageInterceptor);

    // Add the interceptor at the beginning of the interceptors list for highest priority
    dio?.interceptors.insert(0, LanguageInterceptor(language));
  }

  // Function to set language from context
  static void setLanguageFromContext(dynamic context) {
    if (context != null && context.el != null && context.el.language != null) {
      setLanguageParameter(context.el.language);
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.addAll(
      [
        RetryInterceptor(
          dio: dio!,
          logPrint: print, // specify log function (optional)
          retries: 3, // retry count (optional)
          retryDelays: const [
            // set delays between retries (optional)
            Duration(seconds: 1), // wait 1 sec before first retry
            Duration(seconds: 2), // wait 2 sec before second retry
            Duration(seconds: 3), // wait 3 sec before third retry
          ],
        ),
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      ],
    );
  }
}

class LanguageInterceptor extends Interceptor {
  final String language;

  LanguageInterceptor(this.language);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Force add language parameter to ensure it's in the request
    final queryParams = Map<String, dynamic>.from(options.queryParameters);
    queryParams['lang'] = language;
    options.queryParameters = queryParams;

    handler.next(options);
  }
}
