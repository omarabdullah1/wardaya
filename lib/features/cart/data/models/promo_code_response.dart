import 'package:json_annotation/json_annotation.dart';

part 'promo_code_response.g.dart';

@JsonSerializable()
class PromoCodeResponse {
  final String message;
  final double? discountPercentage;
  @JsonKey(name: 'id')
  final String? promoCodeId;

  PromoCodeResponse({
    required this.message,
    this.discountPercentage,
    this.promoCodeId,
  });

  factory PromoCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeResponseToJson(this);
}
