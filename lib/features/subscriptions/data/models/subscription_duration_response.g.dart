// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_duration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDuration _$SubscriptionDurationFromJson(
        Map<String, dynamic> json) =>
    SubscriptionDuration(
      id: json['_id'] as String,
      duration: json['duration'] as String,
      price: (json['price'] as num).toInt(),
      discountedPrice: (json['discounted_price'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SubscriptionDurationToJson(
        SubscriptionDuration instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'duration': instance.duration,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };
