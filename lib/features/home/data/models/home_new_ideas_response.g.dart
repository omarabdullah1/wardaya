// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_new_ideas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeNewIdeasItem _$HomeNewIdeasItemFromJson(Map<String, dynamic> json) =>
    HomeNewIdeasItem(
      id: json['_id'] as String,
      imageUrl: json['image_url'] as String,
      brand: json['brand'] as String,
      occasion: json['occasion'] as String,
      recipient: json['recipient'] as String,
      subCategory: json['subCategory'] as String,
      textOnImage: json['textOnImage'] as String,
      textOnButton: json['textOnButton'] as String,
    );

Map<String, dynamic> _$HomeNewIdeasItemToJson(HomeNewIdeasItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image_url': instance.imageUrl,
      'brand': instance.brand,
      'occasion': instance.occasion,
      'recipient': instance.recipient,
      'subCategory': instance.subCategory,
      'textOnImage': instance.textOnImage,
      'textOnButton': instance.textOnButton,
    };

HomeNewIdeasResponse _$HomeNewIdeasResponseFromJson(
        Map<String, dynamic> json) =>
    HomeNewIdeasResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => HomeNewIdeasItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeNewIdeasResponseToJson(
        HomeNewIdeasResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
