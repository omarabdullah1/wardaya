// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeResponse _$PromoCodeResponseFromJson(Map<String, dynamic> json) =>
    PromoCodeResponse(
      message: json['message'] as String,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      promoCodeId: json['id'] as String?,
    );

Map<String, dynamic> _$PromoCodeResponseToJson(PromoCodeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'discountPercentage': instance.discountPercentage,
      'id': instance.promoCodeId,
    };
