// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionCheckoutRequest _$SubscriptionCheckoutRequestFromJson(
        Map<String, dynamic> json) =>
    SubscriptionCheckoutRequest(
      subscriptionPlan: json['subscription_plan'] as String,
      deliveryFrequency: json['delivery_frequency'] as String,
      duration: json['duration'] as String,
      startDate: json['start_date'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String,
      redirectUrl: json['redirect_url'] as String,
      sourceId: SourceId.fromJson(json['source_id'] as Map<String, dynamic>),
      transactionRef: json['transactionRef'] as String,
      deliveryAreaCity: json['deliveryAreaCity'] as String,
      deliveryInfo:
          DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionCheckoutRequestToJson(
        SubscriptionCheckoutRequest instance) =>
    <String, dynamic>{
      'subscription_plan': instance.subscriptionPlan,
      'delivery_frequency': instance.deliveryFrequency,
      'duration': instance.duration,
      'start_date': instance.startDate,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'redirect_url': instance.redirectUrl,
      'source_id': instance.sourceId,
      'transactionRef': instance.transactionRef,
      'deliveryAreaCity': instance.deliveryAreaCity,
      'deliveryInfo': instance.deliveryInfo,
    };

SourceId _$SourceIdFromJson(Map<String, dynamic> json) => SourceId(
      id: json['id'] as String,
      phone: json['phone'] == null
          ? null
          : PhoneNumber.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceIdToJson(SourceId instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
    };

PhoneNumber _$PhoneNumberFromJson(Map<String, dynamic> json) => PhoneNumber(
      countryCode: json['country_code'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'number': instance.number,
    };

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
      name: json['name'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      shipping: json['shipping'] == null
          ? null
          : Shipping.fromJson(json['shipping'] as Map<String, dynamic>),
      keepIdentitySecret: json['keepIdentitySecret'] as bool,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'shipping': instance.shipping,
      'keepIdentitySecret': instance.keepIdentitySecret,
    };

Shipping _$ShippingFromJson(Map<String, dynamic> json) => Shipping(
      recipientArea: json['recipientArea'] as String?,
      recipientAddress: json['recipientAddress'] as String?,
      extraAddressDetails: json['extraAddressDetails'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShippingToJson(Shipping instance) => <String, dynamic>{
      'recipientArea': instance.recipientArea,
      'recipientAddress': instance.recipientAddress,
      'extraAddressDetails': instance.extraAddressDetails,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
