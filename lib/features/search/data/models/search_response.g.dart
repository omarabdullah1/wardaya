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
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      bundleItems: (json['bundleItems'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      expressDelivery: json['expressDelivery'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
      points: (json['points'] as num?)?.toInt(),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      bundleTypes: (json['bundleTypes'] as List<dynamic>)
          .map((e) => BundleType.fromJson(e as Map<String, dynamic>))
          .toList(),
      careTips: json['careTips'] as String?,
      colors: (json['colors'] as List<dynamic>)
          .map((e) => Color.fromJson(e as Map<String, dynamic>))
          .toList(),
      freeDelivery: json['freeDelivery'] as bool,
      isBundle: json['isBundle'] as bool,
      occasions: (json['occasions'] as List<dynamic>)
          .map((e) => Occasion.fromJson(e as Map<String, dynamic>))
          .toList(),
      premiumFlowers: json['premiumFlowers'] as bool,
      productTypes: (json['productTypes'] as List<dynamic>)
          .map((e) => ProductType.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => Recipient.fromJson(e as Map<String, dynamic>))
          .toList(),
      components: (json['components'] as List<dynamic>)
          .map((e) => Component.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'price': instance.price,
      'dimensions': instance.dimensions,
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
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
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
      'components': instance.components,
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
      imageUrl: json['imageUrl'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      version: (json['__v'] as num).toInt(),
      categoryOrder: (json['categoryOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'subCategories': instance.subCategories,
      '__v': instance.version,
      'categoryOrder': instance.categoryOrder,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      '__v': instance.version,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      coverImageUrlAr: json['coverImageUrlAr'] as String?,
      nameAr: json['nameAr'] as String?,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'coverImageUrlAr': instance.coverImageUrlAr,
      'nameAr': instance.nameAr,
      '__v': instance.version,
    };

BundleType _$BundleTypeFromJson(Map<String, dynamic> json) => BundleType(
      id: json['_id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String?,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$BundleTypeToJson(BundleType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'nameAr': instance.nameAr,
      '__v': instance.version,
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

Occasion _$OccasionFromJson(Map<String, dynamic> json) => Occasion(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$OccasionToJson(Occasion instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      '__v': instance.version,
    };

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) => ProductType(
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      '_id': instance.id,
    };

Recipient _$RecipientFromJson(Map<String, dynamic> json) => Recipient(
      id: json['_id'] as String,
      name: json['name'] as String,
      version: (json['__v'] as num).toInt(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecipientToJson(Recipient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      '__v': instance.version,
      'images': instance.images,
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
