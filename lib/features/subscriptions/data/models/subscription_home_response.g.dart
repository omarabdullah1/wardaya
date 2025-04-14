// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlansResponse _$SubscriptionPlansResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlansResponse(
      id: json['_id'] as String,
      products:
          (json['products'] as List<dynamic>).map((e) => e as String).toList(),
      pricePerDelivery: (json['pricePerDelivery'] as num).toInt(),
      imagesUrl: (json['images_url'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
      miniDescription: json['miniDescription'] as String,
      longDescription: json['longDescription'] as String,
    );

Map<String, dynamic> _$SubscriptionPlansResponseToJson(
        SubscriptionPlansResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'products': instance.products,
      'pricePerDelivery': instance.pricePerDelivery,
      'images_url': instance.imagesUrl,
      'name': instance.name,
      'miniDescription': instance.miniDescription,
      'longDescription': instance.longDescription,
    };
