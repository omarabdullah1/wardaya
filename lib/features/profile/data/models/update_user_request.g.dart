// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'country_code': instance.countryCode,
    };
