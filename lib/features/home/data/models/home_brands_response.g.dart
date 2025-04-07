// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_brands_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBrandsResponse _$HomeBrandsResponseFromJson(Map<String, dynamic> json) =>
    HomeBrandsResponse(
      brands: (json['brands'] as List<dynamic>)
          .map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeBrandsResponseToJson(HomeBrandsResponse instance) =>
    <String, dynamic>{
      'brands': instance.brands,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      version: (json['__v'] as num?)?.toInt() ?? 0,
      coverImageUrl: json['cover_image_url'] as String,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.version,
      'cover_image_url': instance.coverImageUrl,
    };
