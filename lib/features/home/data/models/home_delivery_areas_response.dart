import 'package:json_annotation/json_annotation.dart';

part 'home_delivery_areas_response.g.dart';

@JsonSerializable()
class HomeDeliveryAreasResponse {
  final List<DeliveryArea> deliveryAreas;

  HomeDeliveryAreasResponse({required this.deliveryAreas});

  factory HomeDeliveryAreasResponse.fromJson(List<DeliveryArea> json) {
    return HomeDeliveryAreasResponse(
      deliveryAreas: json
          .map((item) => DeliveryArea.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$HomeDeliveryAreasResponseToJson(this);
}

@JsonSerializable()
class DeliveryArea {
  @JsonKey(name: '_id')
  final String id;
  final String country;
  final String currency;
  final String language;
  final List<City> cities;

  DeliveryArea({
    required this.id,
    required this.country,
    required this.currency,
    required this.language,
    required this.cities,
  });

  factory DeliveryArea.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAreaFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryAreaToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'delivery_price')
  final double deliveryPrice;
  @JsonKey(name: 'free_delivery_limit')
  final double freeDeliveryLimit;
  @JsonKey(name: 'express_delivery_price')
  final double expressDeliveryPrice;
  @JsonKey(includeIfNull: false)
  final String? currency;

  City({
    required this.id,
    required this.name,
    required this.deliveryPrice,
    required this.freeDeliveryLimit,
    required this.expressDeliveryPrice,
    this.currency,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
