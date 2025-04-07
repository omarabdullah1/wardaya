import 'package:json_annotation/json_annotation.dart';

part 'home_category_response.g.dart';

@JsonSerializable()
class HomeCategoryResponse {
  final List<Category> categories;

  HomeCategoryResponse({required this.categories});

  factory HomeCategoryResponse.fromJson(List<dynamic> json) {
    return HomeCategoryResponse(
      categories: json
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'categories': categories.map((e) => e.toJson()).toList(),
      };
}

@JsonSerializable()
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<SubCategory> subCategories;
  @JsonKey(name: '__v', defaultValue: 0)
  final int version;
  final int? categoryOrder;
  final List<Product> products;
  @JsonKey(name: 'name-ar')
  final String? nameAr;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.subCategories,
    required this.version,
    this.categoryOrder,
    required this.products,
    this.nameAr,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String category;
  @JsonKey(name: '__v')
  final int version;

  SubCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.version,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String? productType;
  @JsonKey(defaultValue: [])
  final List<String> images;
  @JsonKey(defaultValue: [])
  final List<String> categories;
  @JsonKey(defaultValue: [])
  final List<String> subCategories;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;
  final String? brand;
  @JsonKey(defaultValue: [])
  final List<String> bundleTypes;
  final String? careTips;
  @JsonKey(defaultValue: [])
  final List<String> colors;
  final bool? freeDelivery;
  @JsonKey(defaultValue: [])
  final List<String> occasions;
  final int? points;
  final bool? premiumFlowers;
  @JsonKey(defaultValue: [])
  final List<String> productTypes;
  @JsonKey(defaultValue: [])
  final List<String> recipients;
  final bool? isBundle;
  @JsonKey(defaultValue: [])
  final List<String> components;
  final Price price;
  final Dimensions? dimensions;
  @JsonKey(defaultValue: [])
  final List<String> menuItems;
  @JsonKey(defaultValue: [])
  final List<String> subMenuItems;
  @JsonKey(defaultValue: [])
  final List<String> bundleItems;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    this.productType,
    required this.images,
    required this.categories,
    required this.subCategories,
    required this.expressDelivery,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.brand,
    required this.bundleTypes,
    this.careTips,
    required this.colors,
    this.freeDelivery,
    required this.occasions,
    this.points,
    this.premiumFlowers,
    required this.productTypes,
    required this.recipients,
    this.isBundle,
    required this.components,
    required this.price,
    this.dimensions,
    required this.menuItems,
    required this.subMenuItems,
    required this.bundleItems,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Price {
  final int total;
  final String currency;

  Price({required this.total, required this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Dimensions {
  final int? width;
  final int? height;

  Dimensions({this.width, this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}
