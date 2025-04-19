import 'package:json_annotation/json_annotation.dart';

part 'subscription_checkout_response.g.dart';

@JsonSerializable()
class SubscriptionCheckoutResponse {
  final bool success;
  final String? ordersId;
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  @JsonKey(name: 'transaction_status')
  final String? transactionStatus;
  final String message;
  final String? error;
  final String? details;

  SubscriptionCheckoutResponse({
    required this.success,
    this.ordersId,
    this.redirectUrl,
    this.transactionId,
    this.transactionStatus,
    required this.message,
    this.error,
    this.details,
  });

  factory SubscriptionCheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionCheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionCheckoutResponseToJson(this);
}
