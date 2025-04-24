// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartItem _$GetCartItemFromJson(Map<String, dynamic> json) => GetCartItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      bundleItems: json['bundleItems'] as List<dynamic>,
    );

Map<String, dynamic> _$GetCartItemToJson(GetCartItem instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'bundleItems': instance.bundleItems,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      menuItems: (json['menuItems'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subMenuItems: (json['subMenuItems'] as List<dynamic>)
          .map((e) => SubMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      productTypes: json['productTypes'] as List<dynamic>,
      colors: json['colors'] as List<dynamic>,
      recipients: json['recipients'] as List<dynamic>,
      bundleTypes: json['bundleTypes'] as List<dynamic>,
      careTips: json['careTips'] as String?,
      freeDelivery: json['freeDelivery'] as bool,
      premiumFlowers: json['premiumFlowers'] as bool,
      productId: json['_id'] as String,
      sku: json['sku'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      productType: json['productType'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
      brand: json['brand'],
      expressDelivery: json['expressDelivery'] as bool,
      points: (json['points'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      components: json['components'] as List<dynamic>,
      bundleItems: (json['bundleItems'] as List<dynamic>)
          .map((e) => BundleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      titleAr: json['title_ar'] as String?,
      careTipsAr: json['careTips_ar'] as String?,
      descriptionAr: json['description_ar'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'price': instance.price,
      'dimensions': instance.dimensions,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'productTypes': instance.productTypes,
      'colors': instance.colors,
      'recipients': instance.recipients,
      'bundleTypes': instance.bundleTypes,
      'careTips': instance.careTips,
      'freeDelivery': instance.freeDelivery,
      'premiumFlowers': instance.premiumFlowers,
      '_id': instance.productId,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'occasions': instance.occasions,
      'brand': instance.brand,
      'expressDelivery': instance.expressDelivery,
      'points': instance.points,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'components': instance.components,
      'bundleItems': instance.bundleItems,
      'title_ar': instance.titleAr,
      'careTips_ar': instance.careTipsAr,
      'description_ar': instance.descriptionAr,
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

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      categoryOrder: (json['categoryOrder'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'subCategories': instance.subCategories,
      'categoryOrder': instance.categoryOrder,
      'name_ar': instance.nameAr,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String,
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'category': instance.category,
      'name_ar': instance.nameAr,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'name_ar': instance.nameAr,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      coverImageUrlAr: json['cover_image_url_ar'] as String?,
      nameAr: json['name_ar'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'cover_image_url': instance.coverImageUrl,
      'cover_image_url_ar': instance.coverImageUrlAr,
      'name_ar': instance.nameAr,
    };

BundleItem _$BundleItemFromJson(Map<String, dynamic> json) => BundleItem(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => BundleCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$BundleItemToJson(BundleItem instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      '_id': instance.id,
    };

BundleCategory _$BundleCategoryFromJson(Map<String, dynamic> json) =>
    BundleCategory(
      categoryTitle: json['category_title'] as String,
      categoryTitleAr: json['category_title_ar'] as String,
      items: (json['items'] as List<dynamic>).map((e) => e as String).toList(),
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

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem();

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{};

SubMenuItem _$SubMenuItemFromJson(Map<String, dynamic> json) => SubMenuItem();

Map<String, dynamic> _$SubMenuItemToJson(SubMenuItem instance) =>
    <String, dynamic>{};
