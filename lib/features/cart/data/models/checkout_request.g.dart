// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutRequest _$CheckoutRequestFromJson(Map<String, dynamic> json) =>
    CheckoutRequest(
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
      giftCard: json['giftCard'] == null
          ? null
          : GiftCard.fromJson(json['giftCard'] as Map<String, dynamic>),
      appliedPromoCode: json['appliedPromoCode'] == null
          ? null
          : AppliedPromoCode.fromJson(
              json['appliedPromoCode'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutRequestToJson(CheckoutRequest instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'redirect_url': instance.redirectUrl,
      'source_id': instance.sourceId,
      'transactionRef': instance.transactionRef,
      'deliveryAreaCity': instance.deliveryAreaCity,
      'deliveryInfo': instance.deliveryInfo,
      'giftCard': instance.giftCard,
      'appliedPromoCode': instance.appliedPromoCode,
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
      deliveryTime: json['deliveryTime'] as String?,
      expressDelivery: json['expressDelivery'] as bool?,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'shipping': instance.shipping,
      'keepIdentitySecret': instance.keepIdentitySecret,
      'deliveryTime': instance.deliveryTime,
      'expressDelivery': instance.expressDelivery,
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

GiftCard _$GiftCardFromJson(Map<String, dynamic> json) => GiftCard(
      template: Template.fromJson(json['template'] as Map<String, dynamic>),
      from: json['from'] as String,
      to: json['to'] as String,
      message: json['message'] as String,
      link: json['link'] as String?,
      handwriting: json['handwriting'] as bool?,
      signatureImageUrl: json['signature_image_url'] as String?,
      qrImageUrl: json['qr_image_url'] as String?,
    );

Map<String, dynamic> _$GiftCardToJson(GiftCard instance) => <String, dynamic>{
      'template': instance.template,
      'from': instance.from,
      'to': instance.to,
      'message': instance.message,
      'link': instance.link,
      'handwriting': instance.handwriting,
      'signature_image_url': instance.signatureImageUrl,
      'qr_image_url': instance.qrImageUrl,
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      id: json['_id'] as String,
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      '_id': instance.id,
    };

AppliedPromoCode _$AppliedPromoCodeFromJson(Map<String, dynamic> json) =>
    AppliedPromoCode(
      id: json['_id'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$AppliedPromoCodeToJson(AppliedPromoCode instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
    };
