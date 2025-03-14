import 'package:json_annotation/json_annotation.dart';

part 'subscription_response.g.dart';

@JsonSerializable()
class SubscriptionResponse {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String userId;
  final Product product;
  @JsonKey(name: 'subscription_plan')
  final String subscriptionPlan;
  @JsonKey(name: 'delivery_frequency')
  final String deliveryFrequency;
  final Duration duration;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  SubscriptionResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.userId,
    required this.product,
    required this.subscriptionPlan,
    required this.deliveryFrequency,
    required this.duration,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}

@JsonSerializable()
class Product {
  final Price price;
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String productType;
  final List<String> images;
  @JsonKey(name: 'categories')
  final List<String> categories;
  @JsonKey(name: 'subCategories')
  final List<String> subCategories;
  final bool expressDelivery;
  final int points;

  Product({
    required this.price,
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    required this.productType,
    required this.images,
    required this.categories,
    required this.subCategories,
    required this.expressDelivery,
    required this.points,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Price {
  final int total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Duration {
  @JsonKey(name: '_id')
  final String id;
  final String duration;
  final int price;
  @JsonKey(name: 'discounted_price')
  final int discountedPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Duration({
    required this.id,
    required this.duration,
    required this.price,
    required this.discountedPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Duration.fromJson(Map<String, dynamic> json) =>
      _$DurationFromJson(json);
  Map<String, dynamic> toJson() => _$DurationToJson(this);
}
