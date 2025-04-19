// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressRequest _$AddressRequestFromJson(Map<String, dynamic> json) =>
    AddressRequest(
      userId: json['userId'] as String?,
      title: json['title'] as String,
      recipientArea: json['recipientArea'] as String,
      recipientName: json['recipientName'] as String,
      recipientCountryCode: json['recipientCountryCode'] as String,
      recipientPhoneNumber: json['recipientPhoneNumber'] as String,
      recipientAddress: json['recipientAddress'] as String,
      extraAddressDetails: json['extraAddressDetails'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );

Map<String, dynamic> _$AddressRequestToJson(AddressRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'recipientArea': instance.recipientArea,
      'recipientName': instance.recipientName,
      'recipientCountryCode': instance.recipientCountryCode,
      'recipientPhoneNumber': instance.recipientPhoneNumber,
      'recipientAddress': instance.recipientAddress,
      'extraAddressDetails': instance.extraAddressDetails,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
