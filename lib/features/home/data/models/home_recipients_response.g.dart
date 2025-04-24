// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_recipients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$HomeRecipientsResponseToJson(
        HomeRecipientsResponse instance) =>
    <String, dynamic>{
      'recipients': instance.recipients,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'images': instance.images,
    };
