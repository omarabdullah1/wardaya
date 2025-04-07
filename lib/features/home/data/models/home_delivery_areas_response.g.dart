// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_delivery_areas_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDeliveryAreasResponse _$HomeDeliveryAreasResponseFromJson(
        Map<String, dynamic> json) =>
    HomeDeliveryAreasResponse(
      deliveryAreas: (json['deliveryAreas'] as List<dynamic>)
          .map((e) => DeliveryArea.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDeliveryAreasResponseToJson(
        HomeDeliveryAreasResponse instance) =>
    <String, dynamic>{
      'deliveryAreas': instance.deliveryAreas,
    };

DeliveryArea _$DeliveryAreaFromJson(Map<String, dynamic> json) => DeliveryArea(
      id: json['_id'] as String,
      country: json['country'] as String,
      currency: json['currency'] as String,
      language: json['language'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryAreaToJson(DeliveryArea instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'country': instance.country,
      'currency': instance.currency,
      'language': instance.language,
      'cities': instance.cities,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: json['_id'] as String,
      name: json['name'] as String,
      deliveryPrice: (json['delivery_price'] as num).toDouble(),
      freeDeliveryLimit: (json['free_delivery_limit'] as num).toDouble(),
      expressDeliveryPrice: (json['express_delivery_price'] as num).toDouble(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'delivery_price': instance.deliveryPrice,
      'free_delivery_limit': instance.freeDeliveryLimit,
      'express_delivery_price': instance.expressDeliveryPrice,
      if (instance.currency case final value?) 'currency': value,
    };
