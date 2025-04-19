import 'package:json_annotation/json_annotation.dart';

part 'add_cart_response.g.dart';

@JsonSerializable()
class AddCartResponse {
  final String message;
  final List<CartItem> cart;

  AddCartResponse({
    required this.message,
    required this.cart,
  });

  factory AddCartResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddCartResponseToJson(this);
}

@JsonSerializable()
class CartItem {
  @JsonKey(name: '_id')
  final String id;
  final String productId;
  final int quantity;
  @JsonKey(defaultValue: [])
  final List<String> bundleItems;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.bundleItems,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
