// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_occasions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOccasionItem _$MyOccasionItemFromJson(Map<String, dynamic> json) =>
    MyOccasionItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$MyOccasionItemToJson(MyOccasionItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      '__v': instance.version,
    };

MyOccasionsResponse _$MyOccasionsResponseFromJson(Map<String, dynamic> json) =>
    MyOccasionsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => MyOccasionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOccasionsResponseToJson(
        MyOccasionsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
