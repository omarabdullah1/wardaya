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
      bundleItems: json['bundleItems'] as List<dynamic>,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      expressDelivery: json['expressDelivery'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      points: (json['points'] as num).toInt(),
      bundleTypes: (json['bundleTypes'] as List<dynamic>)
          .map((e) => BundleType.fromJson(e as Map<String, dynamic>))
          .toList(),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ColorOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => Recipient.fromJson(e as Map<String, dynamic>))
          .toList(),
      components: json['components'] as List<dynamic>,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'price': instance.price,
      'bundleItems': instance.bundleItems,
      'subCategories': instance.subCategories,
      'occasions': instance.occasions,
      'brand': instance.brand,
      'expressDelivery': instance.expressDelivery,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'points': instance.points,
      'bundleTypes': instance.bundleTypes,
      'colors': instance.colors,
      'recipients': instance.recipients,
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

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'category': instance.category,
    };

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };

BundleType _$BundleTypeFromJson(Map<String, dynamic> json) => BundleType(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BundleTypeToJson(BundleType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

ColorOption _$ColorOptionFromJson(Map<String, dynamic> json) => ColorOption(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ColorOptionToJson(ColorOption instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
