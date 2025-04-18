// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isBundle: json['isBundle'] as bool? ?? false,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories:
          ProductResponse._categoriesFromJson(json['categories'] as List),
      subCategories:
          ProductResponse._subCategoriesFromJson(json['subCategories'] as List),
      menuItems: json['menuItems'] as List<dynamic>,
      subMenuItems: json['subMenuItems'] as List<dynamic>,
      productTypes:
          ProductResponse._productTypesFromJson(json['productTypes'] as List),
      occasions: ProductResponse._occasionsFromJson(json['occasions'] as List),
      brand: ProductResponse._brandFromJson(json['brand']),
      expressDelivery: json['expressDelivery'] as bool? ?? false,
      points: (json['points'] as num?)?.toInt() ?? 0,
      components: json['components'] as List<dynamic>,
      dimensions: ProductResponse._dimensionsFromJson(json['dimensions']),
      bundleItems: (json['bundleItems'] as List<dynamic>?)
              ?.map(
                  (e) => BundleItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      colors: ProductResponse._colorsFromJson(json['colors'] as List),
      recipients:
          ProductResponse._recipientsFromJson(json['recipients'] as List),
      bundleTypes: json['bundleTypes'] as List<dynamic>,
      careTips: json['careTips'] as String? ?? '',
      freeDelivery: json['freeDelivery'] as bool? ?? false,
      premiumFlowers: json['premiumFlowers'] as bool? ?? false,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'isBundle': instance.isBundle,
      'price': instance.price,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'productTypes': instance.productTypes,
      'occasions': instance.occasions,
      'brand': instance.brand,
      'expressDelivery': instance.expressDelivery,
      'points': instance.points,
      'components': instance.components,
      'dimensions': instance.dimensions,
      'bundleItems': instance.bundleItems,
      'colors': instance.colors,
      'recipients': instance.recipients,
      'bundleTypes': instance.bundleTypes,
      'careTips': instance.careTips,
      'freeDelivery': instance.freeDelivery,
      'premiumFlowers': instance.premiumFlowers,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      subCategories: json['subCategories'] as List<dynamic>,
      version: (json['__v'] as num).toInt(),
      categoryOrder: (json['categoryOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'subCategories': instance.subCategories,
      '__v': instance.version,
      'categoryOrder': instance.categoryOrder,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'category': instance.category,
      '__v': instance.version,
    };

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) => ProductType(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.version,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.version,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      version: (json['__v'] as num).toInt(),
      coverImageUrl: json['cover_image_url'] as String?,
      coverImageUrlAr: json['cover_image_url_ar'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.version,
      'cover_image_url': instance.coverImageUrl,
      'cover_image_url_ar': instance.coverImageUrlAr,
    };

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

BundleItem _$BundleItemFromJson(Map<String, dynamic> json) => BundleItem(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => BundleCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleItemToJson(BundleItem instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

BundleCategory _$BundleCategoryFromJson(Map<String, dynamic> json) =>
    BundleCategory(
      categoryTitle: json['category_title'] as String,
      items: json['items'] as List<dynamic>,
      isRequired: json['isRequired'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$BundleCategoryToJson(BundleCategory instance) =>
    <String, dynamic>{
      'category_title': instance.categoryTitle,
      'items': instance.items,
      'isRequired': instance.isRequired,
      '_id': instance.id,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: json['_id'] as String,
      name: json['name'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      '__v': instance.version,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
      version: (json['__v'] as num).toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      '__v': instance.version,
      'images': instance.images,
    };

BundleCategoryItem _$BundleCategoryItemFromJson(Map<String, dynamic> json) =>
    BundleCategoryItem(
      categoryTitle: json['category_title'] as String,
      categoryTitleAr: json['category_title_ar'] as String?,
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      isRequired: json['isRequired'] as bool? ?? false,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$BundleCategoryItemToJson(BundleCategoryItem instance) =>
    <String, dynamic>{
      'category_title': instance.categoryTitle,
      'category_title_ar': instance.categoryTitleAr,
      'items': instance.items,
      'isRequired': instance.isRequired,
      '_id': instance.id,
    };

BundleItemResponse _$BundleItemResponseFromJson(Map<String, dynamic> json) =>
    BundleItemResponse(
      categories: (json['categories'] as List<dynamic>?)
              ?.map(
                  (e) => BundleCategoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$BundleItemResponseToJson(BundleItemResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      '_id': instance.id,
    };
