import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  @JsonKey(defaultValue: false)
  final bool isBundle;
  final Price price;
  final List<String> images;

  @JsonKey(fromJson: _categoriesFromJson)
  final List<dynamic> categories;

  @JsonKey(fromJson: _subCategoriesFromJson)
  final List<dynamic> subCategories;

  final List<dynamic> menuItems;
  final List<dynamic> subMenuItems;

  @JsonKey(fromJson: _productTypesFromJson)
  final List<dynamic> productTypes;

  @JsonKey(fromJson: _occasionsFromJson)
  final List<dynamic> occasions;

  @JsonKey(fromJson: _brandFromJson)
  final dynamic brand;

  @JsonKey(defaultValue: false)
  final bool expressDelivery;
  @JsonKey(defaultValue: 0)
  final int points;
  final List<dynamic> components;

  @JsonKey(fromJson: _dimensionsFromJson)
  final Dimensions? dimensions;

  @JsonKey(defaultValue: [])
  final List<BundleItemResponse> bundleItems;

  @JsonKey(fromJson: _colorsFromJson)
  final List<dynamic> colors;

  @JsonKey(fromJson: _recipientsFromJson)
  final List<dynamic> recipients;

  final List<dynamic> bundleTypes;
  @JsonKey(defaultValue: '')
  final String careTips;
  @JsonKey(defaultValue: false)
  final bool freeDelivery;
  @JsonKey(defaultValue: false)
  final bool premiumFlowers;
  final String createdAt;
  final String updatedAt;

  @JsonKey(name: '__v')
  final int version;

  ProductResponse({
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    required this.isBundle,
    required this.price,
    required this.images,
    required this.categories,
    required this.subCategories,
    required this.menuItems,
    required this.subMenuItems,
    required this.productTypes,
    required this.occasions,
    required this.brand,
    required this.expressDelivery,
    required this.points,
    required this.components,
    required this.dimensions,
    required this.bundleItems,
    required this.colors,
    required this.recipients,
    required this.bundleTypes,
    required this.careTips,
    required this.freeDelivery,
    required this.premiumFlowers,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Helper methods to handle mixed data types
  static List<dynamic> _categoriesFromJson(List<dynamic> categories) {
    // This accepts both ID strings and category objects
    return categories;
  }

  static List<dynamic> _subCategoriesFromJson(List<dynamic> subCategories) {
    return subCategories;
  }

  static List<dynamic> _productTypesFromJson(List<dynamic> productTypes) {
    return productTypes;
  }

  static List<dynamic> _occasionsFromJson(List<dynamic> occasions) {
    return occasions;
  }

  static List<dynamic> _colorsFromJson(List<dynamic> colors) {
    return colors;
  }

  static List<dynamic> _recipientsFromJson(List<dynamic> recipients) {
    return recipients;
  }

  static dynamic _brandFromJson(dynamic brand) {
    return brand;
  }

  static Dimensions? _dimensionsFromJson(dynamic dimensions) {
    if (dimensions == null) return null;

    try {
      return Dimensions.fromJson(dimensions as Map<String, dynamic>);
    } catch (e) {
      // Return default dimensions if parsing fails
      return Dimensions(width: 0, height: 0);
    }
  }

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class Price {
  final int total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<dynamic> subCategories;
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
  @JsonKey(name: 'image_url')
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
class ProductType {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: '__v')
  final int version;

  ProductType({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.version,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
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
class Brand {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: '__v')
  final int version;
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'cover_image_url_ar')
  final String? coverImageUrlAr;

  Brand({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.version,
    this.coverImageUrl,
    this.coverImageUrlAr,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class Dimensions {
  final int? width;
  final int? height;

  Dimensions({
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class BundleItem {
  final List<BundleCategory> categories;

  BundleItem({
    required this.categories,
  });

  factory BundleItem.fromJson(Map<String, dynamic> json) =>
      _$BundleItemFromJson(json);
  Map<String, dynamic> toJson() => _$BundleItemToJson(this);
}

@JsonSerializable()
class BundleCategory {
  @JsonKey(name: 'category_title')
  final String categoryTitle;
  final List<dynamic> items;
  final bool isRequired;
  @JsonKey(name: '_id')
  final String id;

  BundleCategory({
    required this.categoryTitle,
    required this.items,
    required this.isRequired,
    required this.id,
  });

  factory BundleCategory.fromJson(Map<String, dynamic> json) =>
      _$BundleCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BundleCategoryToJson(this);
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
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: '__v')
  final int version;
  final List<String>? images;

  Recipient({
    required this.id,
    required this.name,
    required this.version,
    this.images,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);
  Map<String, dynamic> toJson() => _$RecipientToJson(this);
}

@JsonSerializable()
class BundleCategoryItem {
  @JsonKey(name: 'category_title')
  final String categoryTitle;

  @JsonKey(name: 'category_title_ar')
  final String? categoryTitleAr;

  @JsonKey(defaultValue: [])
  final List<String> items;

  @JsonKey(defaultValue: false)
  final bool isRequired;

  @JsonKey(name: '_id')
  final String id;

  BundleCategoryItem({
    required this.categoryTitle,
    this.categoryTitleAr,
    required this.items,
    required this.isRequired,
    required this.id,
  });

  factory BundleCategoryItem.fromJson(Map<String, dynamic> json) =>
      _$BundleCategoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$BundleCategoryItemToJson(this);
}

@JsonSerializable()
class BundleItemResponse {
  @JsonKey(defaultValue: [])
  final List<BundleCategoryItem> categories;

  @JsonKey(name: '_id', defaultValue: '')
  final String id;

  BundleItemResponse({
    required this.categories,
    required this.id,
  });

  factory BundleItemResponse.fromJson(Map<String, dynamic> json) {
    // Handle the case where categories is a direct list
    if (json['categories'] is List) {
      final categoriesList = (json['categories'] as List)
          .map((category) {
            if (category is Map<String, dynamic>) {
              return BundleCategoryItem.fromJson(category);
            }
            return null;
          })
          .whereType<BundleCategoryItem>()
          .toList();

      return BundleItemResponse(
        categories: categoriesList,
        id: json['_id'] as String? ?? '',
      );
    }

    return _$BundleItemResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BundleItemResponseToJson(this);
}
