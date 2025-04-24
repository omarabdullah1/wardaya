// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequestBody _$SearchRequestBodyFromJson(Map<String, dynamic> json) =>
    SearchRequestBody(
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      search: json['search'] as String?,
      brand: json['brand'] as String?,
      occasion: json['occasion'] as String?,
      color: json['color'] as String?,
      recipients: json['recipients'] as String?,
      bundleTypes: json['bundleTypes'] as String?,
      priceRange: json['priceRange'] as String?,
      subMenuItems: json['subMenuItems'] as String?,
      expressDelivery: json['expressDelivery'] as bool?,
    );
