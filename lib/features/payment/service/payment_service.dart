import 'dart:developer';
import '../utils/tap_hash_generator.dart';

class PaymentService {
  // These would typically come from your server or secure storage
  // DO NOT hardcode these in production
  static const String _publicKey =
      "pk_test_HJN863LmO15EtDgo9cqK7sjS"; // Replace with your actual public key
  static const String _secretKey =
      "sk_test_XKokBfNWv6FIYuTMg5sLO7jY"; // Replace with your actual secret key

  /// Creates the SDK configuration for BenefitPay
  static Map<String, dynamic> createBenefitPayConfig({
    required double amount,
    required String currency,
    required String orderId,
    required String firstName,
    required String lastName,
    required String customerEmail,
    required String customerPhone,
    required String transactionReference,
    String countryCode = '+966', // Default to Saudi Arabia code
  }) {
    log("Trying with different customer format for BenefitPay");

    // Generate the hash string
    String hashString = TapHashGenerator.generateTapHashString(
      publicKey: _publicKey,
      secretKey: _secretKey,
      amount: amount,
      currency: currency,
      postUrl: "",
      transactionReference: transactionReference,
    );

    // Format customer data exactly as shown in Swift example
    final config = {
      "operator": {"publicKey": _publicKey, "hashString": hashString},
      "order": {
        "id": orderId,
        "amount": amount,
        "currency": currency,
        "description": "Order payment",
        "reference": transactionReference,
        "metadata": {},
      },
      "merchant": {"id": ""},
      "invoice": {"id": ""},
      "scope": "charge",
      "transaction": {
        "reference": transactionReference,
        "authentication": true,
        "authorize": {"auto": true},
        "paymentAgreement": {
          "id": "",
          "contract": {"id": ""}
        },
        "metadata": {},
        "currency": currency,
        "amount": amount,
      },
      // Customer format updated for BenefitPay Flutter SDK
      "customer": {
        "id": "",
        "names": [
          // Changed from "name" to "names" to match Flutter SDK requirements
          {"lang": "en", "first": firstName, "middle": "", "last": lastName}
        ],
        "contact": {
          "email": customerEmail,
          "phone": {"countryCode": countryCode, "number": customerPhone},
        },
      },
      "locale": "en", // Add locale setting
      "edges": "curved", // Add UI configuration
      "reference": {
        "transaction": "transaction",
        "order": orderId
      }, // Use literal "transaction" as per docs example
      "post": {"url": ""},
      "redirect": {"url": ""},
      "paymentMethod": "benefitpay",
    };

    // Override currency to BHD for BenefitPay if not already BHD
    if (currency != "BHD") {
      log("Warning: BenefitPay typically requires BHD currency. Setting transaction currency to BHD.");
      // Convert amount to BHD (approximate conversion 1 BHD ≈ 10 SAR)
      double bhdAmount = amount / 10.0;

      // Update currency and amount in all relevant places with null safety
      (config["order"] as Map<String, dynamic>)["currency"] = "BHD";
      (config["order"] as Map<String, dynamic>)["amount"] = bhdAmount;
      (config["transaction"] as Map<String, dynamic>)["currency"] = "BHD";
      (config["transaction"] as Map<String, dynamic>)["amount"] = bhdAmount;

      // Generate new hash with BHD currency
      String newHashString = TapHashGenerator.generateTapHashString(
        publicKey: _publicKey,
        secretKey: _secretKey,
        amount: bhdAmount,
        currency: "BHD",
        postUrl: "",
        transactionReference: transactionReference,
      );

      // Add null safety with type casting
      (config["operator"] as Map<String, dynamic>)["hashString"] =
          newHashString;
    }

    log("Using Swift-style dictionary format for customer");
    log("Full Configuration: ${config.toString()}");

    return config;
  }

  /// Creates a configuration for Tap Payment gateway according to the new requested format
  static Map<String, dynamic> createTapPaymentConfig({
    required double amount,
    required String currency,
    required String description,
    required String redirectUrl,
    required String sourceId,
    required String customerEmail,
    required String firstName,
    required String lastName,
    String? phoneCountryCode,
    String? phoneNumber,
    required String transactionRef,
    required String orderRef,
  }) {
    log("Creating Tap Payment configuration");

    // Generate the hash string
    String hashString = TapHashGenerator.generateTapHashString(
      publicKey: _publicKey,
      secretKey: _secretKey,
      amount: amount,
      currency: currency,
      postUrl: "",
      transactionReference: transactionRef,
    );

    // Create base config according to the required format
    final Map<String, dynamic> config = {
      "amount": amount,
      "currency": currency,
      "description": description,
      "redirect_url": redirectUrl,
      "source_id": {
        "id": sourceId
      },
      "transactionRef": transactionRef,
      "orderRef": orderRef,
      "customer": {
        "first_name": firstName,
        "last_name": lastName,
        "email": customerEmail
      },
      "metadata": {
        "udf1": "Metadata 1",
        "udf2": "Metadata 2"
      },
      "reference": {
        "transaction": transactionRef,
        "order": orderRef
      },
      "receipt": {
        "email": true,
        "sms": true
      },
      "merchant": {
        "id": ""
      },
      "operator": {
        "publicKey": _publicKey,
        "hashString": hashString
      },
    };

    // Add phone details if provided (required for STC Pay)
    if (phoneCountryCode != null && phoneNumber != null && sourceId == "src_sa.stcpay") {
      (config["source_id"] as Map<String, dynamic>)["phone"] = {
        "country_code": phoneCountryCode,
        "number": phoneNumber
      };
    }

    log("Tap Payment Configuration: ${config.toString()}");
    return config;
  }

  /// Creates a configuration specifically for general payment methods including mada, Apple Pay, Google Pay, etc.
  static Map<String, dynamic> createGeneralPaymentConfig({
    double amount = 150.0,
    String currency = "SAR",
    String description = "Payment for product XYZ",
    String redirectUrl = "https://www.wardaya.net/cart",
    String sourceId = "src_all", // Default to all payment methods
    String? phoneCountryCode,
    String? phoneNumber,
    String transactionRef = "txn_01",
    String orderRef = "ord_01",
    required String firstName,
    required String lastName,
    required String customerEmail,
  }) {
    log("Creating general payment configuration");

    // Generate the hash string
    String hashString = TapHashGenerator.generateTapHashString(
      publicKey: _publicKey,
      secretKey: _secretKey,
      amount: amount,
      currency: currency,
      postUrl: "",
      transactionReference: transactionRef,
    );

    final Map<String, dynamic> config = {
      "operator": {"publicKey": _publicKey, "hashString": hashString},
      "order": {
        "id": orderRef,
        "amount": amount,
        "currency": currency,
        "description": description,
        "reference": transactionRef,
        "metadata": {},
      },
      "merchant": {"id": ""},
      "scope": "charge",
      "transaction": {
        "reference": transactionRef,
        "authentication": true,
        "authorize": {"auto": true},
        "metadata": {},
        "currency": currency,
        "amount": amount,
      },
      "customer": {
        "id": "",
        "names": [
          {"lang": "en", "first": firstName, "middle": "", "last": lastName}
        ],
        "contact": {
          "email": customerEmail,
        },
      },
      "source": {"id": sourceId},
      "redirect": {"url": redirectUrl},
      "post": {"url": ""},
      "reference": {"transaction": transactionRef, "order": orderRef},
    };

    // Add phone details if provided (required for STC Pay)
    if (phoneCountryCode != null &&
        phoneNumber != null &&
        sourceId == "src_sa.stcpay") {
      (config["source"] as Map<String, dynamic>)["phone"] = {
        "country_code": phoneCountryCode,
        "number": phoneNumber
      };
    }

    log("Payment Configuration: ${config.toString()}");
    return config;
  }
}
