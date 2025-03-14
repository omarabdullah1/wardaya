// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDataBody _$FilterDataBodyFromJson(Map<String, dynamic> json) =>
    FilterDataBody(
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      brand: json['brand'] as String?,
      occasion: json['occasion'] as String?,
      color: json['color'] as String?,
      recipients: json['recipients'] as String?,
      bundleTypes: json['bundleTypes'] as String?,
      priceRange: json['priceRange'] as String?,
    );

Map<String, dynamic> _$FilterDataBodyToJson(FilterDataBody instance) =>
    <String, dynamic>{
      'category': instance.category,
      'subCategory': instance.subCategory,
      'brand': instance.brand,
      'occasion': instance.occasion,
      'color': instance.color,
      'recipients': instance.recipients,
      'bundleTypes': instance.bundleTypes,
      'priceRange': instance.priceRange,
    };
