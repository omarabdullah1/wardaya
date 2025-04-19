// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'addresses': instance.addresses,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      recipientArea: json['recipientArea'] as String? ?? '',
      recipientAddress: json['recipientAddress'] as String? ?? '',
      extraAddressDetails: json['extraAddressDetails'] as String? ?? '',
      recipientPhoneNumber: json['recipientPhoneNumber'] as String?,
      recipientName: json['recipientName'] as String?,
      recipientCountryCode: json['recipientCountryCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      version: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'recipientArea': instance.recipientArea,
      'recipientAddress': instance.recipientAddress,
      'extraAddressDetails': instance.extraAddressDetails,
      'recipientPhoneNumber': instance.recipientPhoneNumber,
      'recipientName': instance.recipientName,
      'recipientCountryCode': instance.recipientCountryCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      '__v': instance.version,
    };
