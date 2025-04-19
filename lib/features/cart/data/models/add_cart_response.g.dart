// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartResponse _$AddCartResponseFromJson(Map<String, dynamic> json) =>
    AddCartResponse(
      message: json['message'] as String,
      cart: (json['cart'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddCartResponseToJson(AddCartResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart': instance.cart,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['_id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      bundleItems: (json['bundleItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'bundleItems': instance.bundleItems,
    };
