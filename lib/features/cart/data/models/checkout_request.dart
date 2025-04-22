import 'package:json_annotation/json_annotation.dart';

part 'checkout_request.g.dart';

@JsonSerializable()
class CheckoutRequest {
  @JsonKey(name: 'start_date')
  final String startDate;

  final double amount;
  final String currency;
  final String description;

  @JsonKey(name: 'redirect_url')
  final String redirectUrl;

  @JsonKey(name: 'source_id')
  final SourceId sourceId;

  final String transactionRef;
  final String deliveryAreaCity;
  final DeliveryInfo deliveryInfo;
  final GiftCard? giftCard;

  @JsonKey(name: 'appliedPromoCode')
  final AppliedPromoCode? appliedPromoCode;

  CheckoutRequest({
    required this.startDate,
    required this.amount,
    required this.currency,
    required this.description,
    required this.redirectUrl,
    required this.sourceId,
    required this.transactionRef,
    required this.deliveryAreaCity,
    required this.deliveryInfo,
    this.giftCard,
    this.appliedPromoCode,
  });

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}

@JsonSerializable()
class SourceId {
  final String id;
  final PhoneNumber? phone;

  SourceId({
    required this.id,
    this.phone,
  });

  factory SourceId.fromJson(Map<String, dynamic> json) =>
      _$SourceIdFromJson(json);

  Map<String, dynamic> toJson() => _$SourceIdToJson(this);
}

@JsonSerializable()
class PhoneNumber {
  @JsonKey(name: 'country_code')
  final String countryCode;
  final String number;

  PhoneNumber({
    required this.countryCode,
    required this.number,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);
}

@JsonSerializable()
class DeliveryInfo {
  final String name;
  final String phone;
  @JsonKey(name: 'countryCode')
  final String countryCode;
  final Shipping? shipping;
  final bool keepIdentitySecret;

  @JsonKey(name: 'deliveryTime')
  final String? deliveryTime;

  @JsonKey(name: 'expressDelivery')
  final bool? expressDelivery;

  DeliveryInfo({
    required this.name,
    required this.phone,
    required this.countryCode,
    this.shipping,
    required this.keepIdentitySecret,
    this.deliveryTime,
    this.expressDelivery,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) =>
      _$DeliveryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryInfoToJson(this);
}

@JsonSerializable()
class Shipping {
  final String? recipientArea;
  final String? recipientAddress;
  final String? extraAddressDetails;
  final double? latitude;
  final double? longitude;

  Shipping({
    this.recipientArea,
    this.recipientAddress,
    this.extraAddressDetails,
    this.latitude,
    this.longitude,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) =>
      _$ShippingFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToJson(this);
}

@JsonSerializable()
class GiftCard {
  final Template template;
  final String from;
  final String to;
  final String message;
  final String? link;
  final bool? handwriting;

  @JsonKey(name: 'signature_image_url')
  final String? signatureImageUrl;

  @JsonKey(name: 'qr_image_url')
  final String? qrImageUrl;

  GiftCard({
    required this.template,
    required this.from,
    required this.to,
    required this.message,
    this.link,
    this.handwriting,
    this.signatureImageUrl,
    this.qrImageUrl,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) =>
      _$GiftCardFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCardToJson(this);
}

@JsonSerializable()
class Template {
  @JsonKey(name: '_id')
  final String id;

  Template({
    required this.id,
  });

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}

@JsonSerializable()
class AppliedPromoCode {
  @JsonKey(name: '_id')
  final String id;

  final String code;

  AppliedPromoCode({
    required this.id,
    required this.code,
  });

  factory AppliedPromoCode.fromJson(Map<String, dynamic> json) =>
      _$AppliedPromoCodeFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedPromoCodeToJson(this);
}
