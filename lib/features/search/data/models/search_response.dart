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
  final List<dynamic> bundleItems;
  final List<Category> subCategories;
  final List<Occasion> occasions;
  final Brand brand;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;
  final List<BundleType> bundleTypes;
  final List<ColorOption> colors;
  final List<Recipient> recipients;
  final List<dynamic> components;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    required this.productType,
    required this.images,
    required this.price,
    required this.bundleItems,
    required this.subCategories,
    required this.occasions,
    required this.brand,
    required this.expressDelivery,
    required this.createdAt,
    required this.updatedAt,
    required this.points,
    required this.bundleTypes,
    required this.colors,
    required this.recipients,
    required this.components,
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
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String category;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  Occasion({
    required this.id,
    required this.name,
    required this.imageUrl,
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

  Brand({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BundleType {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  BundleType({required this.id, required this.name});

  factory BundleType.fromJson(Map<String, dynamic> json) =>
      _$BundleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BundleTypeToJson(this);
}

@JsonSerializable()
class ColorOption {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  ColorOption({required this.id, required this.name});

  factory ColorOption.fromJson(Map<String, dynamic> json) =>
      _$ColorOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ColorOptionToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  Recipient({required this.id, required this.name});

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);

  Map<String, dynamic> toJson() => _$RecipientToJson(this);
}
