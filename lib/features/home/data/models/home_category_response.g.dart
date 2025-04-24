// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: (json['__v'] as num?)?.toInt() ?? 0,
      categoryOrder: (json['categoryOrder'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      nameAr: json['name-ar'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'subCategories': instance.subCategories,
      '__v': instance.version,
      'categoryOrder': instance.categoryOrder,
      'products': instance.products,
      'name-ar': instance.nameAr,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String,
      version: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'category': instance.category,
      '__v': instance.version,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      categories: json['categories'] == null
          ? []
          : Product._parseIdList(json['categories'] as List),
      subCategories: json['subCategories'] == null
          ? []
          : Product._parseIdList(json['subCategories'] as List),
      expressDelivery: json['expressDelivery'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt() ?? 0,
      brand: json['brand'] as String?,
      bundleTypes: json['bundleTypes'] == null
          ? []
          : Product._parseIdList(json['bundleTypes'] as List),
      careTips: json['careTips'] as String?,
      colors: json['colors'] == null
          ? []
          : Product._parseIdList(json['colors'] as List),
      freeDelivery: json['freeDelivery'] as bool?,
      occasions: json['occasions'] == null
          ? []
          : Product._parseIdList(json['occasions'] as List),
      points: (json['points'] as num?)?.toInt(),
      premiumFlowers: json['premiumFlowers'] as bool?,
      productTypes: json['productTypes'] == null
          ? []
          : Product._parseIdList(json['productTypes'] as List),
      recipients: json['recipients'] == null
          ? []
          : Product._parseIdList(json['recipients'] as List),
      isBundle: json['isBundle'] as bool?,
      components: (json['components'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      menuItems: (json['menuItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subMenuItems: (json['subMenuItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      bundleItems: (json['bundleItems'] as List<dynamic>?)
              ?.map((e) => BundleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
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
      '__v': instance.version,
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
      'components': instance.components,
      'price': instance.price,
      'dimensions': instance.dimensions,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'bundleItems': instance.bundleItems,
    };

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

Map<String, dynamic> _$BundleItemToJson(BundleItem instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

BundleCategory _$BundleCategoryFromJson(Map<String, dynamic> json) =>
    BundleCategory(
      categoryTitle: json['category_title'] as String,
      categoryTitleAr: json['category_title_ar'] as String?,
      items: json['items'] == null
          ? []
          : BundleCategory._parseIdList(json['items'] as List),
      isRequired: json['isRequired'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$BundleCategoryToJson(BundleCategory instance) =>
    <String, dynamic>{
      'category_title': instance.categoryTitle,
      'category_title_ar': instance.categoryTitleAr,
      'items': instance.items,
      'isRequired': instance.isRequired,
      '_id': instance.id,
    };
