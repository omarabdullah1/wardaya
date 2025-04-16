import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// A service to handle product sharing functionality throughout the app
class ShareService {
  static final ShareService _instance = ShareService._internal();
  
  factory ShareService() => _instance;
  
  ShareService._internal();
  
  /// Share a product with the given ID and title
  Future<void> shareProduct(BuildContext context, {
    required String productId,
    required String productTitle,
  }) async {
    // Create a share link for the product using the website's URL architecture
    final String productUrl = 'https://www.wardaya.net/products/product/$productId';
    
    // Create share message
    final String shareMessage = 'Check out this product: $productTitle\n$productUrl';
    
    try {
      // Try to share via the native share sheet if available
      await _tryNativeSharing(context, shareMessage);
    } catch (e) {
      // Log error
      debugPrint('Error sharing product: $e');
      
      // Fallback to clipboard
      await _fallbackToClipboard(context, shareMessage);
    }
  }
  
  /// Try to share using native options (SMS, email, etc.)
  Future<void> _tryNativeSharing(BuildContext context, String message) async {
    bool shared = false;
    
    // Try SMS sharing
    final Uri smsUri = Uri.parse('sms:?body=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
      shared = true;
    } 
    
    // If SMS didn't work, try email
    if (!shared) {
      final Uri mailUri = Uri.parse(
        'mailto:?subject=${Uri.encodeComponent('Check out this product from Wardaya')}'
        '&body=${Uri.encodeComponent(message)}'
      );
      
      if (await canLaunchUrl(mailUri)) {
        await launchUrl(mailUri);
        shared = true;
      }
    }
    
    // If neither worked, fall back to clipboard
    if (!shared) {
      await _fallbackToClipboard(context, message);
    }
  }
  
  /// Fall back to clipboard copying when sharing options fail
  Future<void> _fallbackToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}