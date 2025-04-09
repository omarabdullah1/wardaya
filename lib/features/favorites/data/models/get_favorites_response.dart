import 'package:json_annotation/json_annotation.dart';

part 'get_favorites_response.g.dart';

@JsonSerializable()
class GetFavoritesResponse {
  final List<GetFavoriteProduct> favorites;

  GetFavoritesResponse({
    required this.favorites,
  });

  factory GetFavoritesResponse.fromJson(Map<String, dynamic> json) {
    // Handle the case where the API returns an object with a 'favorites' field
    if (json.containsKey('favorites')) {
      return _$GetFavoritesResponseFromJson(json);
    } else {
      // If we got a direct list (which happens sometimes), create a response with that list
      return GetFavoritesResponse(favorites: []);
    }
  }

  // Special handling for direct list response
  static GetFavoritesResponse fromJsonList(List<dynamic> jsonList) {
    return GetFavoritesResponse(
      favorites: jsonList
          .map((item) =>
              GetFavoriteProduct.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$GetFavoritesResponseToJson(this);
}

// Use the same structure but with a different name
@JsonSerializable()
class GetFavoriteProduct {
  final Price? price;
  final Dimensions? dimensions;
  final List<dynamic>? menuItems;
  final List<dynamic>? subMenuItems;
  final List<dynamic>? bundleItems;
  @JsonKey(name: '_id')
  final String id;
  final String? sku;
  final String? title;
  final String? description;
  final String? productType;
  final List<String>? images;
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

  GetFavoriteProduct({
    this.price,
    this.dimensions,
    this.menuItems,
    this.subMenuItems,
    this.bundleItems,
    required this.id,
    this.sku,
    this.title,
    this.description,
    this.productType,
    this.images,
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

  factory GetFavoriteProduct.fromJson(Map<String, dynamic> json) =>
      _$GetFavoriteProductFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavoriteProductToJson(this);
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
