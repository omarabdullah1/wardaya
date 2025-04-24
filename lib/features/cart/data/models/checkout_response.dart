import 'package:json_annotation/json_annotation.dart';

part 'checkout_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckoutResponse {
  final bool success;
  @JsonKey(name: 'orderId')
  final String? ordersId;
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  @JsonKey(name: 'transaction_status')
  final String? transactionStatus;
  final String? message;
  final String? error;
  final String? details;

  CheckoutResponse({
    required this.success,
    this.ordersId,
    this.redirectUrl,
    this.transactionId,
    this.transactionStatus,
    this.message,
    this.error,
    this.details,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
