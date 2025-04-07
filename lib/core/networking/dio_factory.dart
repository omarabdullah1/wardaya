import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';
import '../helpers/network_connectivity.dart';

/// Helper class to work with cached responses
class CacheUtils {
  /// Check if a response came from cache
  static bool isResponseFromCache(Response? response) {
    return response?.headers.value('x-from-cache') == 'true';
  }

  /// Force a fresh request (skip cache)
  static Map<String, dynamic> forceFreshRequestOptions() {
    return {'forceRefresh': true};
  }

  /// Create options for a request that should bypass cache and force a fresh request
  static Options getForceFreshOptions({Options? options}) {
    final newOptions = options ?? Options();
    final Map<String, dynamic> extras = Map.from(newOptions.extra ?? {});
    extras['forceRefresh'] = true;
    return newOptions.copyWith(extra: extras);
  }
}

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
        // Add cache interceptor to handle 504 errors with cached responses
        CacheInterceptor(),

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

/// Cache interceptor that saves and retrieves responses
class CacheInterceptor extends Interceptor {
  // Define cache prefix constant
  static const String _cachePrefix = 'cache_';
  static const Duration _defaultMaxAge =
      Duration(hours: 1); // Default cache expiry

  /// Get a cached response for a request
  Future<Response?> _getCachedResponse(RequestOptions options) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cacheKey = _generateCacheKey(options);

    // Check if we have this request in cache
    final String? cacheData = prefs.getString(cacheKey);
    if (cacheData == null) return null;

    try {
      final Map<String, dynamic> cacheMap = jsonDecode(cacheData);

      // Check if the cache has expired
      final DateTime timestamp =
          DateTime.fromMillisecondsSinceEpoch(cacheMap['timestamp']);
      final bool isCacheValid =
          DateTime.now().difference(timestamp) < _defaultMaxAge;

      // If cache is still valid, return the cached response
      if (isCacheValid) {
        log('Using cached response for: ${options.path}');
        return Response(
          data: cacheMap['data'],
          headers: Headers.fromMap(cacheMap['headers'] ?? {}),
          statusCode: cacheMap['statusCode'] ?? 200,
          requestOptions: options,
        );
      } else {
        // Cache expired, remove it
        await prefs.remove(cacheKey);
        return null;
      }
    } catch (e) {
      log('Error reading cache: $e');
      // If there's any error reading the cache, ignore it
      return null;
    }
  }

  /// Save a response to cache
  Future<void> _saveResponseToCache(Response response) async {
    // Only cache successful GET responses
    if (response.requestOptions.method != 'GET' || response.statusCode != 200) {
      return;
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String cacheKey = _generateCacheKey(response.requestOptions);

      // Prepare cache data
      final Map<String, dynamic> cacheMap = {
        'data': response.data,
        'headers': response.headers.map,
        'statusCode': response.statusCode,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      // Save to cache
      await prefs.setString(cacheKey, jsonEncode(cacheMap));
    } catch (e) {
      log('Error saving to cache: $e');
      // Ignore cache saving errors
    }
  }

  /// Generate a unique key for caching based on the request
  String _generateCacheKey(RequestOptions options) {
    // Create a cache key from the request path and query parameters
    String paramsSorted = '';
    if (options.queryParameters.isNotEmpty) {
      final sortedParams = Map.fromEntries(
          options.queryParameters.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key)));
      paramsSorted = jsonEncode(sortedParams);
    }

    return '$_cachePrefix${options.path}$paramsSorted';
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Only attempt to use cache for GET requests
    if (options.method == 'GET') {
      // Mark this request as potentially cacheable
      options.extra['cache'] = true;

      // Check if we have internet connection
      final bool isConnected =
          await NetworkConnectivity.hasInternetConnection();

      // Check for cached response first
      final cachedResponse = await _getCachedResponse(options);

      // If we're offline and have a cached response, use it immediately
      if (!isConnected && cachedResponse != null) {
        log('No internet connection, using cached response for: ${options.path}');
        cachedResponse.headers.add('x-from-cache', 'true');
        return handler.resolve(cachedResponse);
      }

      // If online but we have a valid cached response and not forcing refresh
      if (cachedResponse != null && options.extra['forceRefresh'] != true) {
        return handler.resolve(cachedResponse);
      }

      // If we're offline and don't have a cache, we need to fail fast
      if (!isConnected) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'No internet connection',
            type: DioExceptionType.connectionError,
          ),
        );
      }
    }

    // Continue with the request if online or not a GET request
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Save successful GET responses to cache
    if (response.requestOptions.extra['cache'] == true &&
        response.statusCode == 200) {
      await _saveResponseToCache(response);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if it's a 504 or other network error, and if we should try to use cache
    if ((err.response?.statusCode == 504 ||
            err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.sendTimeout) &&
        err.requestOptions.method == 'GET') {
      // Try to get a cached response
      final cachedResponse = await _getCachedResponse(err.requestOptions);
      if (cachedResponse != null) {
        // Add a header to indicate this is a cached response
        cachedResponse.headers.add('x-from-cache', 'true');
        log('Resolving network error with cached data for: ${err.requestOptions.path}');
        return handler.resolve(cachedResponse);
      }
    }

    // If we don't have a cached response or it's not a cacheable error, continue
    handler.next(err);
  }
}
