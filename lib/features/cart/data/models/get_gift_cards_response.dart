import 'package:json_annotation/json_annotation.dart';

part 'get_gift_cards_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetGiftCardsResponse {
  final List<GiftCardTemplate> giftCards;

  GetGiftCardsResponse({required this.giftCards});

  factory GetGiftCardsResponse.fromJson(dynamic json) {
    if (json is List) {
      return GetGiftCardsResponse(
        giftCards: json.map((item) => GiftCardTemplate.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic> && json.containsKey('giftCards')) {
      return _$GetGiftCardsResponseFromJson(json);
    }
    return GetGiftCardsResponse(giftCards: []);
  }

  Map<String, dynamic> toJson() => _$GetGiftCardsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiftCardTemplate {
  @JsonKey(name: '_id')
  final String id;
  final Price price;
  final String image;
  final List<Occasion> occasions;
  final String name;
  @JsonKey(name: 'name_ar')
  final String? nameAr;
  @JsonKey(name: 'suggested_messages', defaultValue: [])
  final List<String> suggestedMessages;
  @JsonKey(name: 'suggested_messages_ar', defaultValue: [])
  final List<String> suggestedMessagesAr;

  GiftCardTemplate({
    required this.id,
    required this.price,
    required this.image,
    required this.occasions,
    required this.name,
    this.nameAr,
    this.suggestedMessages = const [],
    this.suggestedMessagesAr = const [],
  });

  factory GiftCardTemplate.fromJson(Map<String, dynamic> json) {
    // Handle string values in suggested messages
    List<String> processSuggestedMessages(dynamic messages) {
      if (messages == null) return [];
      if (messages is List) {
        return messages.map((e) => e?.toString() ?? '').toList();
      }
      return [];
    }

    // Pre-process suggested messages
    json['suggested_messages'] =
        processSuggestedMessages(json['suggested_messages']);
    json['suggested_messages_ar'] =
        processSuggestedMessages(json['suggested_messages_ar']);

    return _$GiftCardTemplateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GiftCardTemplateToJson(this);
}

@JsonSerializable()
class Price {
  final double total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: '__v')
  final int version;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  Occasion({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.version,
    this.nameAr,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);
  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}
