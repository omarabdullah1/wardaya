import 'package:json_annotation/json_annotation.dart';

part 'add_favorites_response.g.dart';

@JsonSerializable()
class AddFavoritesResponse {
  final String? message;
  final List<AddFavoriteProduct>? favorites;

  AddFavoritesResponse({
    this.message,
    this.favorites,
  });

  // Special constructor for error cases
  factory AddFavoritesResponse.withMessage(String message) {
    return AddFavoritesResponse(message: message, favorites: null);
  }

  factory AddFavoritesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddFavoritesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoritesResponseToJson(this);
}

@JsonSerializable()
class AddFavoriteProduct {
  final Price? price;
  final Dimensions? dimensions;
  final List<dynamic>? menuItems;
  final List<dynamic>? subMenuItems;
  final List<dynamic>? bundleItems;
  @JsonKey(name: '_id')
  final String id;
  final String? sku;
  final String title;
  final String? description;
  final String? productType;
  final List<String> images;
  final List<String>? categories;
  final List<String>? subCategories;
  final bool? expressDelivery;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  final String? brand;
  final List<dynamic>? bundleTypes;
  final String? careTips;
  final List<dynamic>? colors;
  final bool? freeDelivery;
  final List<String>? occasions;
  final int? points;
  final bool? premiumFlowers;
  final List<String>? productTypes;
  final List<String>? recipients;
  final bool? isBundle;
  @JsonKey(name: 'careTips_ar')
  final String? careTipsAr;
  @JsonKey(name: 'description_ar')
  final String? descriptionAr;
  @JsonKey(name: 'title_ar')
  final String? titleAr;
  final List<dynamic>? components;

  AddFavoriteProduct({
    this.price,
    this.dimensions,
    this.menuItems,
    this.subMenuItems,
    this.bundleItems,
    required this.id,
    this.sku,
    required this.title,
    this.description,
    this.productType,
    required this.images,
    this.categories,
    this.subCategories,
    this.expressDelivery,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.brand,
    this.bundleTypes,
    this.careTips,
    this.colors,
    this.freeDelivery,
    this.occasions,
    this.points,
    this.premiumFlowers,
    this.productTypes,
    this.recipients,
    this.isBundle,
    this.careTipsAr,
    this.descriptionAr,
    this.titleAr,
    this.components,
  });

  factory AddFavoriteProduct.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteProductFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoriteProductToJson(this);
}

@JsonSerializable()
class Price {
  final int total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Dimensions {
  final dynamic width;
  final dynamic height;

  Dimensions({
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}
