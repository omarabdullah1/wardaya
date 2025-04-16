import 'package:json_annotation/json_annotation.dart';

part 'subscription_home_response.g.dart';

@JsonSerializable()
class SubscriptionPlansResponse {
  @JsonKey(name: '_id')
  final String id;
  final List<String> products;
  final int pricePerDelivery;
  @JsonKey(name: 'images_url')
  final List<String> imagesUrl;
  final String name;
  final String miniDescription;
  final String longDescription;

  SubscriptionPlansResponse({
    required this.id,
    required this.products,
    required this.pricePerDelivery,
    required this.imagesUrl,
    required this.name,
    required this.miniDescription,
    required this.longDescription,
  });

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlansResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlansResponseToJson(this);
}