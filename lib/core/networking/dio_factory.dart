import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
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
        ..options.receiveTimeout = timeOut
        ..options.sendTimeout = timeOut
        // Fix: Correctly validate status codes to throw exceptions for 4xx and 5xx responses
        // This ensures error responses are properly caught and handled
        ..options.validateStatus = (status) {
          return status != null && status >= 200 && status < 300;
        };
      addDioHeaders();
      addDioInterceptor();
      if (_currentLanguage != null) {
        setLanguageParameter(_currentLanguage!);
      }
      return dio!;
    } else {
      return dio!;
    }
  }

  /// Resets the Dio instance, clearing all interceptors and creating a new instance
  /// This is useful when auth tokens expire or session timeouts occur
  static Future<Dio> resetDio() async {
    log('Resetting Dio instance...');

    // Cancel all ongoing requests
    if (dio != null) {
      dio!.close(force: true);
      dio = null;
    }

    // Create a new instance
    Dio newDio = getDio();
    log('Dio instance reset successfully');

    return newDio;
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
    if (dio == null) return;

    dio?.interceptors
        .removeWhere((interceptor) => interceptor is LanguageInterceptor);
    dio?.interceptors.insert(0, LanguageInterceptor(language));
  }

  static void setLanguageFromContext(dynamic context) {
    if (context != null && context.el != null && context.el.language != null) {
      setLanguageParameter(context.el.language);
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.addAll([
      // Moved debouncing to be the first interceptor
      DebouncingInterceptor(debounceDelay: const Duration(milliseconds: 1000)),

      // Special handler for 408 Request Timeout errors
      SessionTimeoutInterceptor(),

      // Custom retry interceptor with debounce checks
      _DebounceAwareRetryInterceptor(
        dio: dio!,
        logPrint: log,
        retries: 3, // Reduced retries
        retryDelays: const [
          Duration(seconds: 2),
          Duration(seconds: 4),
          Duration(seconds: 8),
        ],
      ),

      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ]);
  }

  static void handleSessionTimeout() {
    // Implement navigation to login screen here
  }
}

class LanguageInterceptor extends Interceptor {
  final String language;

  LanguageInterceptor(this.language);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final queryParams = Map<String, dynamic>.from(options.queryParameters);
    queryParams['lang'] = language;
    options.queryParameters = queryParams;
    handler.next(options);
  }
}

class _DebounceAwareRetryInterceptor extends Interceptor {
  final Dio dio;
  final void Function(String message) logPrint;
  final int retries;
  final List<Duration> retryDelays;

  _DebounceAwareRetryInterceptor({
    required this.dio,
    required this.logPrint,
    required this.retries,
    required this.retryDelays,
  });

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final requestKey =
        '${err.requestOptions.path}${err.requestOptions.queryParameters}';

    // Don't retry if this isn't a network error
    if (err.type != DioExceptionType.connectionError &&
        err.type != DioExceptionType.connectionTimeout &&
        err.type != DioExceptionType.receiveTimeout &&
        err.type != DioExceptionType.sendTimeout) {
      return handler.next(err);
    }

    final extra = err.requestOptions.extra;
    final attempt = (extra['ro_attempt'] as int?) ?? 0;
    final nextAttempt = attempt + 1;

    if (nextAttempt > retries) {
      logPrint('Max retry attempts ($retries) reached for $requestKey');
      return handler.next(err);
    }

    final delay = retryDelays[attempt];
    logPrint(
        'Will retry $requestKey in ${delay.inSeconds}s (attempt $nextAttempt/$retries)');

    await Future.delayed(delay);

    try {
      final response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
          extra: {
            ...err.requestOptions.extra,
            'ro_attempt': nextAttempt,
          },
        ),
        queryParameters: err.requestOptions.queryParameters,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}

class DebouncingInterceptor extends Interceptor {
  final Duration _debounceDelay;
  final Map<String, DateTime> _lastRequestTimes = {};

  DebouncingInterceptor({Duration? debounceDelay})
      : _debounceDelay = debounceDelay ?? const Duration(milliseconds: 800);

  String _getRequestKey(RequestOptions options) {
    return '${options.method}:${options.path}:${options.queryParameters}';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestKey = _getRequestKey(options);
    final now = DateTime.now();
    final lastRequestTime = _lastRequestTimes[requestKey];

    if (lastRequestTime != null &&
        now.difference(lastRequestTime) < _debounceDelay) {
      log('Debounced duplicate request: $requestKey');
      return handler.reject(DioException(
        requestOptions: options,
        error: 'Request debounced',
        type: DioExceptionType.cancel,
      ));
    }

    _lastRequestTimes[requestKey] = now;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestKey = _getRequestKey(response.requestOptions);
    _lastRequestTimes.remove(requestKey);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestKey = _getRequestKey(err.requestOptions);
    _lastRequestTimes.remove(requestKey);
    handler.next(err);
  }
}

class SessionTimeoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 408) {
      log('Session timeout detected: ${err.requestOptions.path}');

      // Clear all data from SharedPreferences and SecureStorage
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();

      // Navigate to login screen
      _navigateToLogin();
    }
    handler.next(err);
  }

  void _navigateToLogin() {
    // Use a static method to navigate to login screen to handle
    // the navigation from non-context environment
    DioFactory.handleSessionTimeout();
  }
}
