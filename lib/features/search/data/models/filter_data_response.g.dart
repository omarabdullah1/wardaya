// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDataResponse _$FilterDataResponseFromJson(Map<String, dynamic> json) =>
    FilterDataResponse(
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ColorOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => Recipient.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleTypes: (json['bundleTypes'] as List<dynamic>)
          .map((e) => BundleType.fromJson(e as Map<String, dynamic>))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceRanges: (json['priceRanges'] as List<dynamic>)
          .map((e) => PriceRange.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterDataResponseToJson(FilterDataResponse instance) =>
    <String, dynamic>{
      'colors': instance.colors,
      'recipients': instance.recipients,
      'bundleTypes': instance.bundleTypes,
      'occasions': instance.occasions,
      'priceRanges': instance.priceRanges,
    };

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
      id: json['_id'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'count': instance.count,
    };

ColorOption _$ColorOptionFromJson(Map<String, dynamic> json) => ColorOption(
      id: json['_id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ColorOptionToJson(ColorOption instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

BundleType _$BundleTypeFromJson(Map<String, dynamic> json) => BundleType(
      id: json['_id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$BundleTypeToJson(BundleType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };
