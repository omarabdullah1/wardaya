// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_occasion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOccasionResponse _$CreateOccasionResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOccasionResponse(
      message: json['message'] as String,
      userOccasion:
          MyOccasionItem.fromJson(json['userOccasion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOccasionResponseToJson(
        CreateOccasionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userOccasion': instance.userOccasion,
    };

CreateOccasionRequest _$CreateOccasionRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOccasionRequest(
      name: json['name'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$CreateOccasionRequestToJson(
        CreateOccasionRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
    };
