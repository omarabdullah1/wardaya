// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_occassions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccassionsItem _$OccassionsItemFromJson(Map<String, dynamic> json) =>
    OccassionsItem(
      id: json['_id'] as String,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$OccassionsItemToJson(OccassionsItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };

OccassionsResponse _$OccassionsResponseFromJson(Map<String, dynamic> json) =>
    OccassionsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => OccassionsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OccassionsResponseToJson(OccassionsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
