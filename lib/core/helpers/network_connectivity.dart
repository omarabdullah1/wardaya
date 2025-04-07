import 'dart:io';
import 'dart:developer';

/// A utility class to check network connectivity
class NetworkConnectivity {
  /// Check if the device has an active internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      // First attempt: Try to establish a connection to Google's DNS
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      log('Network connectivity check failed: $e');
      try {
        // Second attempt: Try to establish a connection to Cloudflare's DNS
        final resultBackup = await InternetAddress.lookup('1.1.1.1')
            .timeout(const Duration(seconds: 3));
        if (resultBackup.isNotEmpty && resultBackup[0].rawAddress.isNotEmpty) {
          return true;
        }
      } catch (e) {
        log('Backup network connectivity check failed: $e');
        return false;
      }
    }
    return false;
  }
}
