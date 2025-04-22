// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserResponse _$UpdateUserResponseFromJson(Map<String, dynamic> json) =>
    UpdateUserResponse(
      message: json['message'] as String,
      user: ProfileResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateUserResponseToJson(UpdateUserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };
