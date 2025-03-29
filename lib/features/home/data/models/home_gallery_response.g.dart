// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_gallery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryItem _$GalleryItemFromJson(Map<String, dynamic> json) => GalleryItem(
      id: json['_id'] as String,
      brand: json['brand'] as String?,
      occasion: json['occasion'] as String?,
      recipient: json['recipient'] as String?,
      subCategory: json['subCategory'] as String?,
      textOnImage: json['textOnImage'] as String,
      textOnButton: json['textOnButton'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$GalleryItemToJson(GalleryItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'brand': instance.brand,
      'occasion': instance.occasion,
      'recipient': instance.recipient,
      'subCategory': instance.subCategory,
      'textOnImage': instance.textOnImage,
      'textOnButton': instance.textOnButton,
      'imageUrl': instance.imageUrl,
    };

GalleryResponse _$GalleryResponseFromJson(Map<String, dynamic> json) =>
    GalleryResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => GalleryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GalleryResponseToJson(GalleryResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
