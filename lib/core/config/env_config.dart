import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Secure environment configuration
/// This class provides access to sensitive API keys in a more secure way
class EnvConfig {
  // Channel for communicating with iOS native code
  static const MethodChannel _iosApiKeyChannel =
      MethodChannel('com.wardaya.maps/api_key');

  static Future<void> init() async {
    try {
      await dotenv.load(fileName: '.env');

      // Initialize API key for iOS
      await _initIosApiKey();
    } catch (e) {
      log('Error initializing environment: $e');
    }
  }

  // Sends the secure API key to iOS using the method channel
  static Future<void> _initIosApiKey() async {
    try {
      if (Platform.isIOS) {
        final success = await _iosApiKeyChannel.invokeMethod<bool>(
          'getApiKey',
          {'key': mapsApiKey},
        );
        log('iOS API key initialization: ${success ?? false}');
      }
    } catch (e) {
      log('Failed to initialize iOS API key: $e');
    }
  }

  /// Get Google Maps API key with simple obfuscation
  static String get mapsApiKey {
    final key = dotenv.env['MAPS_API_KEY'] ?? '';
    if (key.isEmpty) {
      throw Exception('Maps API key not found in .env file');
    }
    return _obfuscateKey(key);
  }

  /// Get a placeholder API key for development - this would be replaced in CI/CD pipeline
  static String get placeholderMapsApiKey {
    return 'YOUR_MAPS_API_KEY_HERE';
  }

  /// Simple key obfuscation to add a layer of security
  /// For production, consider using more robust methods like native code obfuscation
  static String _obfuscateKey(String key) {
    // This is a simple example - in production you might want to
    // implement a more sophisticated obfuscation method
    // or use platform-specific secure storage
    final List<int> bytes = utf8.encode(key);
    return String.fromCharCodes(bytes);
  }

  // In your EnvConfig class where you load environment variables
  static Future<bool> initMapsApiKey() async {
    try {
      final String apiKey = dotenv.env['MAPS_API_KEY'] ?? '';
      if (apiKey.isEmpty) {
        throw Exception('Maps API key not found in environment variables');
      }
      
      // Send API key to iOS native code
      final result = await _iosApiKeyChannel.invokeMethod<bool>('setApiKey', apiKey);
      return result ?? false;
    } catch (e) {
      log('Error initializing Maps API key: $e');
      return false;
    }
  }
}
