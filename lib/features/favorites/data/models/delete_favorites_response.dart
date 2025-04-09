import 'package:json_annotation/json_annotation.dart';

class DeleteFavoritesResponse {
  final String? message;
  final List<DeleteFavoriteProduct>? favorites;

  DeleteFavoritesResponse({
    this.message,
    this.favorites,
  });

  // Special constructor for error cases
  factory DeleteFavoritesResponse.withMessage(String message) {
    return DeleteFavoritesResponse(message: message, favorites: null);
  }

  factory DeleteFavoritesResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFavoritesResponse(
      message: json['message'] as String?,
      favorites: json['favorites'] == null
          ? null
          : (json['favorites'] as List<dynamic>)
              .map((e) =>
                  DeleteFavoriteProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'favorites': favorites?.map((e) => e.toJson()).toList(),
      };
}

// Use the same structure as AddFavoriteProduct but with a different name
class DeleteFavoriteProduct {
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

  DeleteFavoriteProduct({
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

  factory DeleteFavoriteProduct.fromJson(Map<String, dynamic> json) {
    return DeleteFavoriteProduct(
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      menuItems: json['menuItems'] as List<dynamic>?,
      subMenuItems: json['subMenuItems'] as List<dynamic>?,
      bundleItems: json['bundleItems'] as List<dynamic>?,
      id: json['_id'] as String,
      sku: json['sku'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      productType: json['productType'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expressDelivery: json['expressDelivery'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      brand: json['brand'] as String?,
      bundleTypes: json['bundleTypes'] as List<dynamic>?,
      careTips: json['careTips'] as String?,
      colors: json['colors'] as List<dynamic>?,
      freeDelivery: json['freeDelivery'] as bool?,
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      points: json['points'] as int?,
      premiumFlowers: json['premiumFlowers'] as bool?,
      productTypes: (json['productTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isBundle: json['isBundle'] as bool?,
      careTipsAr: json['careTips_ar'] as String?,
      descriptionAr: json['description_ar'] as String?,
      titleAr: json['title_ar'] as String?,
      components: json['components'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'price': price?.toJson(),
        'dimensions': dimensions?.toJson(),
        'menuItems': menuItems,
        'subMenuItems': subMenuItems,
        'bundleItems': bundleItems,
        '_id': id,
        'sku': sku,
        'title': title,
        'description': description,
        'productType': productType,
        'images': images,
        'categories': categories,
        'subCategories': subCategories,
        'expressDelivery': expressDelivery,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
        'brand': brand,
        'bundleTypes': bundleTypes,
        'careTips': careTips,
        'colors': colors,
        'freeDelivery': freeDelivery,
        'occasions': occasions,
        'points': points,
        'premiumFlowers': premiumFlowers,
        'productTypes': productTypes,
        'recipients': recipients,
        'isBundle': isBundle,
        'careTips_ar': careTipsAr,
        'description_ar': descriptionAr,
        'title_ar': titleAr,
        'components': components,
      };
}

class Price {
  final int total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      total: (json['total'] as num).toInt(),
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'currency': currency,
      };
}

class Dimensions {
  final dynamic width;
  final dynamic height;

  Dimensions({
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
      };
}
