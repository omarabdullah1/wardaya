// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_occasion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOccasion _$UserOccasionFromJson(Map<String, dynamic> json) => UserOccasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$UserOccasionToJson(UserOccasion instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      '__v': instance.version,
    };

CreateOccasionResponse _$CreateOccasionResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOccasionResponse(
      message: json['message'] as String,
      userOccasion:
          UserOccasion.fromJson(json['userOccasion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOccasionResponseToJson(
        CreateOccasionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userOccasion': instance.userOccasion,
    };
