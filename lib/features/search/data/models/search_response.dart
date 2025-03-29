import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final List<Product> products;

  SearchResponse({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.products,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String productType;
  final List<String> images;
  final Price price;
  final Dimensions? dimensions;
  @JsonKey(defaultValue: [])
  final List<String> menuItems; // Changed from List<dynamic> to List<String>
  @JsonKey(defaultValue: [])
  final List<String> subMenuItems; // Changed from List<dynamic> to List<String>
  @JsonKey(defaultValue: [])
  final List<String> bundleItems; // Changed from List<dynamic> to List<String>
  @JsonKey(defaultValue: [])
  final List<ParentCategory> categories;
  @JsonKey(defaultValue: [])
  final List<SubCategory> subCategories;
  @JsonKey(defaultValue: [])
  final List<Occasion> occasions;
  @JsonKey(defaultValue: [])
  final List<BundleType> bundleTypes;
  @JsonKey(defaultValue: [])
  final List<ColorOption> colors;
  @JsonKey(defaultValue: [])
  final List<Recipient> recipients;
  @JsonKey(defaultValue: [])
  final List<Component> components;

  // Define missing fields
  final Brand? brand;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;
  final String? careTips;
  final bool? freeDelivery;
  final bool? premiumFlowers;
  final bool? isBundle;
  @JsonKey(name: 'productTypes', defaultValue: [])
  final List<String> productTypeIds;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    required this.productType,
    required this.images,
    required this.price,
    this.dimensions,
    required this.menuItems,
    required this.subMenuItems,
    required this.bundleItems,
    required this.categories,
    required this.subCategories,
    required this.occasions,
    required this.bundleTypes,
    required this.colors,
    required this.recipients,
    required this.components,
    required this.productTypeIds,
    this.brand,
    required this.expressDelivery,
    required this.createdAt,
    required this.updatedAt,
    required this.points,
    this.careTips,
    this.freeDelivery,
    this.premiumFlowers,
    this.isBundle,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Dimensions {
  final double? width;
  final double? height;

  Dimensions({this.width, this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Component {
  final String item;
  final int quantity;
  @JsonKey(name: '_id')
  final String id;

  Component({
    required this.item,
    required this.quantity,
    required this.id,
  });

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}

@JsonSerializable()
class ProductType {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  ProductType({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class Price {
  final int total;
  final String currency;

  Price({required this.total, required this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

// Renamed from Category to SubCategory
@JsonSerializable()
class SubCategory {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String category;
  @JsonKey(name: '__v')
  final int v;

  SubCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class ParentCategory {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl; // Make nullable
  @JsonKey(name: 'subCategories', defaultValue: [])
  final List<String> subCategories; // Provide default value
  @JsonKey(name: '__v')
  final int v;
  final int? categoryOrder;

  ParentCategory({
    required this.id,
    required this.name,
    this.imageUrl, // Make nullable
    required this.subCategories,
    required this.v,
    this.categoryOrder,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCategoryToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: '__v')
  final int? v;

  Occasion({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.v,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: '__v')
  final int? v;

  Brand({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.coverImageUrl,
    this.v,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BundleType {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: '__v')
  final int? v;

  BundleType({
    required this.id,
    required this.name,
    this.v,
  });

  factory BundleType.fromJson(Map<String, dynamic> json) =>
      _$BundleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BundleTypeToJson(this);
}

@JsonSerializable()
class ColorOption {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: '__v')
  final int? v;

  ColorOption({
    required this.id,
    required this.name,
    this.v,
  });

  factory ColorOption.fromJson(Map<String, dynamic> json) =>
      _$ColorOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ColorOptionToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final List<String>? images;
  @JsonKey(name: '__v')
  final int? v;

  Recipient({required this.id, required this.name, this.images, this.v});

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);

  Map<String, dynamic> toJson() => _$RecipientToJson(this);
}
