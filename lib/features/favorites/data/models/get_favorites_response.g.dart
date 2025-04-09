// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favorites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavoritesResponse _$GetFavoritesResponseFromJson(
        Map<String, dynamic> json) =>
    GetFavoritesResponse(
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => GetFavoriteProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFavoritesResponseToJson(
        GetFavoritesResponse instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };

GetFavoriteProduct _$GetFavoriteProductFromJson(Map<String, dynamic> json) =>
    GetFavoriteProduct(
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
      title: json['title'] as String?,
      description: json['description'] as String?,
      productType: json['productType'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expressDelivery: json['expressDelivery'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      bundleTypes: json['bundleTypes'] as List<dynamic>?,
      careTips: json['careTips'] as String?,
      colors: json['colors'] as List<dynamic>?,
      freeDelivery: json['freeDelivery'] as bool?,
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      points: (json['points'] as num?)?.toInt(),
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

Map<String, dynamic> _$GetFavoriteProductToJson(GetFavoriteProduct instance) =>
    <String, dynamic>{
      'price': instance.price,
      'dimensions': instance.dimensions,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'bundleItems': instance.bundleItems,
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'expressDelivery': instance.expressDelivery,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'brand': instance.brand,
      'bundleTypes': instance.bundleTypes,
      'careTips': instance.careTips,
      'colors': instance.colors,
      'freeDelivery': instance.freeDelivery,
      'occasions': instance.occasions,
      'points': instance.points,
      'premiumFlowers': instance.premiumFlowers,
      'productTypes': instance.productTypes,
      'recipients': instance.recipients,
      'isBundle': instance.isBundle,
      'careTips_ar': instance.careTipsAr,
      'description_ar': instance.descriptionAr,
      'title_ar': instance.titleAr,
      'components': instance.components,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      width: json['width'],
      height: json['height'],
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
