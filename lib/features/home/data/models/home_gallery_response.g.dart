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
      imageUrl: json['image_url'] as String,
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
      'image_url': instance.imageUrl,
    };

Map<String, dynamic> _$GalleryResponseToJson(GalleryResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
