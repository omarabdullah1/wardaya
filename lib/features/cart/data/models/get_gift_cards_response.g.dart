// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_gift_cards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGiftCardsResponse _$GetGiftCardsResponseFromJson(
        Map<String, dynamic> json) =>
    GetGiftCardsResponse(
      giftCards: (json['giftCards'] as List<dynamic>)
          .map((e) => GiftCardTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGiftCardsResponseToJson(
        GetGiftCardsResponse instance) =>
    <String, dynamic>{
      'giftCards': instance.giftCards.map((e) => e.toJson()).toList(),
    };

GiftCardTemplate _$GiftCardTemplateFromJson(Map<String, dynamic> json) =>
    GiftCardTemplate(
      id: json['_id'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      image: json['image'] as String,
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      nameAr: json['name_ar'] as String?,
      suggestedMessages: (json['suggested_messages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      suggestedMessagesAr: (json['suggested_messages_ar'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$GiftCardTemplateToJson(GiftCardTemplate instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'price': instance.price.toJson(),
      'image': instance.image,
      'occasions': instance.occasions.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'name_ar': instance.nameAr,
      'suggested_messages': instance.suggestedMessages,
      'suggested_messages_ar': instance.suggestedMessagesAr,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      version: (json['__v'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.version,
      'name_ar': instance.nameAr,
    };
