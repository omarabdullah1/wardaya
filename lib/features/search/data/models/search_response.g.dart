// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'products': instance.products,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
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
              ?.map((e) => e as String)
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => ParentCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      occasions: (json['occasions'] as List<dynamic>?)
              ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bundleTypes: (json['bundleTypes'] as List<dynamic>?)
              ?.map((e) => BundleType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => ColorOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      recipients: (json['recipients'] as List<dynamic>?)
              ?.map((e) => Recipient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      components: (json['components'] as List<dynamic>?)
              ?.map((e) => Component.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productTypeIds: (json['productTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      expressDelivery: json['expressDelivery'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      points: (json['points'] as num).toInt(),
      careTips: json['careTips'] as String?,
      freeDelivery: json['freeDelivery'] as bool?,
      premiumFlowers: json['premiumFlowers'] as bool?,
      isBundle: json['isBundle'] as bool?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'price': instance.price,
      'dimensions': instance.dimensions,
      'menuItems': instance.menuItems,
      'subMenuItems': instance.subMenuItems,
      'bundleItems': instance.bundleItems,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'occasions': instance.occasions,
      'bundleTypes': instance.bundleTypes,
      'colors': instance.colors,
      'recipients': instance.recipients,
      'components': instance.components,
      'brand': instance.brand,
      'expressDelivery': instance.expressDelivery,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'points': instance.points,
      'careTips': instance.careTips,
      'freeDelivery': instance.freeDelivery,
      'premiumFlowers': instance.premiumFlowers,
      'isBundle': instance.isBundle,
      'productTypes': instance.productTypeIds,
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

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      item: json['item'] as String,
      quantity: (json['quantity'] as num).toInt(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) => ProductType(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      category: json['category'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'category': instance.category,
      '__v': instance.v,
    };

ParentCategory _$ParentCategoryFromJson(Map<String, dynamic> json) =>
    ParentCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      v: (json['__v'] as num).toInt(),
      categoryOrder: (json['categoryOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParentCategoryToJson(ParentCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'subCategories': instance.subCategories,
      '__v': instance.v,
      'categoryOrder': instance.categoryOrder,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      '__v': instance.v,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      coverImageUrl: json['cover_image_url'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'cover_image_url': instance.coverImageUrl,
      '__v': instance.v,
    };

BundleType _$BundleTypeFromJson(Map<String, dynamic> json) => BundleType(
      id: json['_id'] as String,
      name: json['name'] as String,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BundleTypeToJson(BundleType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      '__v': instance.v,
    };

ColorOption _$ColorOptionFromJson(Map<String, dynamic> json) => ColorOption(
      id: json['_id'] as String,
      name: json['name'] as String,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ColorOptionToJson(ColorOption instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      '__v': instance.v,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'images': instance.images,
      '__v': instance.v,
    };
