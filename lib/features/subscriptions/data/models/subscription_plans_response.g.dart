// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plans_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
      id: json['id'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pricePerDelivery: (json['pricePerDelivery'] as num).toDouble(),
      imagesUrl:
          (json['imagesUrl'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      miniDescription: json['miniDescription'] as String,
      longDescription: json['longDescription'] as String,
    );

Map<String, dynamic> _$SubscriptionPlanToJson(SubscriptionPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'pricePerDelivery': instance.pricePerDelivery,
      'imagesUrl': instance.imagesUrl,
      'name': instance.name,
      'miniDescription': instance.miniDescription,
      'longDescription': instance.longDescription,
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions:
          Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      menuItems: json['menuItems'] as List<dynamic>,
      subMenuItems: json['subMenuItems'] as List<dynamic>,
      id: json['id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      expressDelivery: json['expressDelivery'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num).toInt(),
      points: (json['points'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      bundleTypes: json['bundleTypes'] as List<dynamic>,
      careTips: json['careTips'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      freeDelivery: json['freeDelivery'] as bool?,
      isBundle: json['isBundle'] as bool?,
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      premiumFlowers: json['premiumFlowers'] as bool?,
      productTypes: (json['productTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      titleAr: json['titleAr'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      careTipsAr: json['careTipsAr'] as String?,
      components: json['components'] as List<dynamic>?,
      bundleItems: json['bundleItems'] as List<dynamic>?,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'price': instance.price,
      'dimensions': instance.dimensions,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'expressDelivery': instance.expressDelivery,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'version': instance.version,
      'points': instance.points,
      'brand': instance.brand,
      'bundleTypes': instance.bundleTypes,
      'careTips': instance.careTips,
      'colors': instance.colors,
      'freeDelivery': instance.freeDelivery,
      'isBundle': instance.isBundle,
      'occasions': instance.occasions,
      'premiumFlowers': instance.premiumFlowers,
      'productTypes': instance.productTypes,
      'recipients': instance.recipients,
      'titleAr': instance.titleAr,
      'descriptionAr': instance.descriptionAr,
      'careTipsAr': instance.careTipsAr,
      'components': instance.components,
      'bundleItems': instance.bundleItems,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
