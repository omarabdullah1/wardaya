// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionCheckoutResponse _$SubscriptionCheckoutResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionCheckoutResponse(
      success: json['success'] as bool,
      ordersId: json['ordersId'] as String?,
      redirectUrl: json['redirect_url'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionStatus: json['transaction_status'] as String?,
      message: json['message'] as String,
      error: json['error'] as String?,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$SubscriptionCheckoutResponseToJson(
        SubscriptionCheckoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'ordersId': instance.ordersId,
      'redirect_url': instance.redirectUrl,
      'transaction_id': instance.transactionId,
      'transaction_status': instance.transactionStatus,
      'message': instance.message,
      'error': instance.error,
      'details': instance.details,
    };
