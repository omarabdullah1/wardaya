import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:async';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;
  static String? _currentLanguage;

  static Dio getDio() {
    // Increase timeout values to handle slow server responses
    Duration timeOut = const Duration(seconds: 60);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.sendTimeout = timeOut
        // Add validateStatus to accept 504 responses and handle them gracefully
        ..options.validateStatus = (status) {
          return status != null && status < 600;
        };
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
        // Add debouncing interceptor with increased delay
        DebouncingInterceptor(debounceDelay: const Duration(milliseconds: 800)),

        // Custom implementation of retry logic for better handling of network issues
        RetryInterceptor(
          dio: dio!,
          logPrint: (message) => log('Retry: $message'), // Better logging
          retries: 5, // Maximum number of retries
          retryDelays: const [
            Duration(seconds: 1),
            Duration(seconds: 2),
            Duration(seconds: 3),
            Duration(seconds: 5),
            Duration(seconds: 8),
          ],
          retryEvaluator: (DioException error, int attempt) {
            // Check for specific status codes that should be retried
            if (error.response != null) {
              final statusCode = error.response?.statusCode;
              if (statusCode == 504 || statusCode == 503 || statusCode == 502) {
                log('Retrying status code $statusCode (attempt $attempt): ${error.requestOptions.path}');
                return true;
              }
            }

            // Check for network-related errors
            if (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.sendTimeout ||
                error.type == DioExceptionType.connectionError) {
              log('Retrying network error (attempt $attempt): ${error.type} - ${error.requestOptions.path}');
              return true;
            }

            // Don't retry other errors
            return false;
          },
        ),

        // Custom interceptor to handle 504 errors gracefully
        _GatewayTimeoutInterceptor(),

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

/// Custom interceptor to handle 504 Gateway Timeout errors
class _GatewayTimeoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 504) {
      // Log the 504 error for debugging
      log('Gateway Timeout (504) detected for request: ${err.requestOptions.path}');

      // The error will be handled by the CacheInterceptor
    }

    handler.next(err);
  }
}

/// Interceptor that implements debouncing for API requests
class DebouncingInterceptor extends Interceptor {
  final Map<String, Timer> _timers = {};
  final Duration _debounceDelay;
  final Map<String, Completer<Response>> _pendingRequests = {};

  DebouncingInterceptor({Duration? debounceDelay})
      : _debounceDelay = debounceDelay ?? const Duration(milliseconds: 500);

  String _getRequestKey(RequestOptions options) {
    // Create a unique key based on request path and parameters
    return '${options.path}${options.queryParameters}${options.data.hashCode}';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestKey = _getRequestKey(options);

    // Cancel any existing timer for this request
    _timers[requestKey]?.cancel();

    // Check if there's already a pending request with the same key
    if (_pendingRequests.containsKey(requestKey)) {
      // If there is one, cancel the current request and let the pending one handle it
      final completer = _pendingRequests[requestKey]!;
      completer.future.then(
        (response) => handler.resolve(response),
        onError: (e, stack) {
          if (e is DioException) {
            handler.reject(e);
          } else {
            handler.reject(
              DioException(
                requestOptions: options,
                error: e,
                stackTrace: stack,
              ),
            );
          }
        },
      );
      return;
    }

    // Create a new completer for this request
    final completer = Completer<Response>();
    _pendingRequests[requestKey] = completer;

    // Create a new timer for this request
    _timers[requestKey] = Timer(_debounceDelay, () {
      // When the timer fires, send the request
      options.extra['_debounced'] = true;

      // We'll use the next interceptor
      handler.next(options);
    });

    // We'll handle the completion in onResponse or onError
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestKey = _getRequestKey(response.requestOptions);

    // Complete the pending request if it exists
    if (response.requestOptions.extra['_debounced'] == true &&
        _pendingRequests.containsKey(requestKey)) {
      _pendingRequests[requestKey]?.complete(response);
      _pendingRequests.remove(requestKey);
      _timers.remove(requestKey);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestKey = _getRequestKey(err.requestOptions);

    // Complete with error if it's a debounced request
    if (err.requestOptions.extra['_debounced'] == true &&
        _pendingRequests.containsKey(requestKey)) {
      _pendingRequests[requestKey]?.completeError(err);
      _pendingRequests.remove(requestKey);
      _timers.remove(requestKey);
    }

    handler.next(err);
  }
}
