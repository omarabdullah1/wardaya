// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveCartResponse _$RemoveCartResponseFromJson(Map<String, dynamic> json) =>
    RemoveCartResponse(
      message: json['message'] as String,
      cart: (json['cart'] as List<dynamic>)
          .map((e) => RemoveCartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemoveCartResponseToJson(RemoveCartResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart': instance.cart,
    };

RemoveCartItem _$RemoveCartItemFromJson(Map<String, dynamic> json) =>
    RemoveCartItem(
      id: json['_id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      bundleItems: (json['bundleItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoveCartItemToJson(RemoveCartItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'bundleItems': instance.bundleItems,
    };
