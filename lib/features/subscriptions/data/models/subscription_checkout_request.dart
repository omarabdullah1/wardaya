import 'package:json_annotation/json_annotation.dart';

part 'subscription_checkout_request.g.dart';

@JsonSerializable()
class SubscriptionCheckoutRequest {
  @JsonKey(name: 'subscription_plan')
  final String subscriptionPlan;

  @JsonKey(name: 'delivery_frequency')
  final String deliveryFrequency;

  final String duration;

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

  SubscriptionCheckoutRequest({
    required this.subscriptionPlan,
    required this.deliveryFrequency,
    required this.duration,
    required this.startDate,
    required this.amount,
    required this.currency,
    required this.description,
    required this.redirectUrl,
    required this.sourceId,
    required this.transactionRef,
    required this.deliveryAreaCity,
    required this.deliveryInfo,
  });

  factory SubscriptionCheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionCheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionCheckoutRequestToJson(this);
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

  DeliveryInfo({
    required this.name,
    required this.phone,
    required this.countryCode,
    this.shipping,
    required this.keepIdentitySecret,
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
