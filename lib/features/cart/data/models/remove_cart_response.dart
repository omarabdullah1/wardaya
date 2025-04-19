import 'package:json_annotation/json_annotation.dart';

part 'remove_cart_response.g.dart';

@JsonSerializable()
class RemoveCartResponse {
  final String message;
  final List<RemoveCartItem> cart;

  RemoveCartResponse({
    required this.message,
    required this.cart,
  });

  factory RemoveCartResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveCartResponseToJson(this);
}

@JsonSerializable()
class RemoveCartItem {
  @JsonKey(name: '_id')
  final String id;
  final String productId;
  final int quantity;
  @JsonKey(defaultValue: [])
  final List<String> bundleItems;

  RemoveCartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.bundleItems,
  });

  factory RemoveCartItem.fromJson(Map<String, dynamic> json) =>
      _$RemoveCartItemFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveCartItemToJson(this);
}
