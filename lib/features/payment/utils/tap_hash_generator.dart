import 'dart:convert';
import 'package:crypto/crypto.dart';

class TapHashGenerator {
  /// Generates a hash string required for Tap payments
  ///
  /// [publicKey] - The Tap public key for you as a merchant pk_.....
  /// [secretKey] - The Tap secret key for you as a merchant sk_.....
  /// [amount] - The amount you are passing to the SDK
  /// [currency] - The currency code you are passing to the SDK (e.g., SAR, KWD)
  /// [postUrl] - The post URL you are passing to the SDK (optional)
  /// [transactionReference] - The reference.transaction you are passing to the SDK (optional)
  static String generateTapHashString({
    required String publicKey,
    required String secretKey,
    required double amount,
    required String currency,
    String postUrl = "",
    String transactionReference = "",
  }) {
    // Let us generate our encryption key
    var key = utf8.encode(secretKey);

    // For amounts, we need to make sure they have the correct number of decimal points
    // For BHD we need them to have 3 decimal points
    var formattedAmount = amount.toStringAsFixed(3);

    // Format the string that we will hash
    String toBeHashed = "x_publickey$publicKey"
        "x_amount$formattedAmount"
        "x_currency$currency";

    // Add optional parameters if they're provided
    if (postUrl.isNotEmpty) {
      toBeHashed += "x_post$postUrl";
    }

    if (transactionReference.isNotEmpty) {
      toBeHashed += "x_transaction$transactionReference";
    }

    // Generate the HMAC-SHA256 hash
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(utf8.encode(toBeHashed));

    return digest.toString();
  }
}
