// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) =>
    CheckoutResponse(
      success: json['success'] as bool,
      ordersId: json['orderId'] as String?,
      redirectUrl: json['redirect_url'] as String?,
      transactionId: json['transaction_id'] as String?,
      transactionStatus: json['transaction_status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'orderId': instance.ordersId,
      'redirect_url': instance.redirectUrl,
      'transaction_id': instance.transactionId,
      'transaction_status': instance.transactionStatus,
      'message': instance.message,
      'error': instance.error,
      'details': instance.details,
    };
