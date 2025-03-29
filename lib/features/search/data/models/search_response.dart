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
  final Price price;
  final Dimensions? dimensions;
  final List<Product> bundleItems;
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String productType;
  final List<String> images;
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;
  final int? points;
  final Brand? brand;
  final List<BundleType> bundleTypes;
  final String? careTips;
  final List<Color> colors;
  final bool freeDelivery;
  final bool isBundle;
  final List<Occasion> occasions;
  final bool premiumFlowers;
  final List<ProductType> productTypes;
  final List<Recipient> recipients;
  final List<Component> components;

  Product({
    required this.price,
    this.dimensions,
    required this.bundleItems,
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    required this.productType,
    required this.images,
    required this.categories,
    required this.subCategories,
    required this.expressDelivery,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.points,
    this.brand,
    required this.bundleTypes,
    this.careTips,
    required this.colors,
    required this.freeDelivery,
    required this.isBundle,
    required this.occasions,
    required this.premiumFlowers,
    required this.productTypes,
    required this.recipients,
    required this.components,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Helper method to get full image URLs
  List<String> get fullImageUrls => images.map((image) {
        if (image.startsWith('http')) return image;
        return 'https://wardaya-tan.vercel.app$image';
      }).toList();
}

@JsonSerializable()
class Price {
  final double total;
  final String currency;

  Price({required this.total, required this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
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
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> subCategories;
  @JsonKey(name: '__v')
  final int version;
  final int? categoryOrder;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.subCategories,
    required this.version,
    this.categoryOrder,
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
  final String? imageUrl;
  final String category;
  @JsonKey(name: '__v')
  final int version;

  SubCategory({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.category,
    required this.version,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? imageUrl;
  final String? coverImageUrl;
  final String? coverImageUrlAr;
  final String? nameAr;
  @JsonKey(name: '__v')
  final int version;

  Brand({
    required this.id,
    required this.name,
    this.imageUrl,
    this.coverImageUrl,
    this.coverImageUrlAr,
    this.nameAr,
    required this.version,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BundleType {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? nameAr;
  @JsonKey(name: '__v')
  final int version;

  BundleType({
    required this.id,
    required this.name,
    this.nameAr,
    required this.version,
  });

  factory BundleType.fromJson(Map<String, dynamic> json) =>
      _$BundleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$BundleTypeToJson(this);
}

@JsonSerializable()
class Color {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: '__v')
  final int version;

  Color({
    required this.id,
    required this.name,
    required this.version,
  });

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
  Map<String, dynamic> toJson() => _$ColorToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? imageUrl;
  @JsonKey(name: '__v')
  final int version;

  Occasion({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.version,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);
  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}

@JsonSerializable()
class ProductType {
  @JsonKey(name: '_id')
  final String id;

  ProductType({required this.id});

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: '__v')
  final int version;
  final List<String> images;

  Recipient({
    required this.id,
    required this.name,
    required this.version,
    required this.images,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);
  Map<String, dynamic> toJson() => _$RecipientToJson(this);
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
