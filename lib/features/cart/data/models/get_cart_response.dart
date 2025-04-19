import 'package:json_annotation/json_annotation.dart';

part 'get_cart_response.g.dart';

@JsonSerializable()
class GetCartResponse {
  final List<GetCartItem> items;

  GetCartResponse({required this.items});

  factory GetCartResponse.fromJson(List<dynamic> json) =>
      GetCartResponse(items: json.map((e) => GetCartItem.fromJson(e)).toList());

  List<dynamic> toJson() => items.map((e) => e.toJson()).toList();
}

@JsonSerializable()
class GetCartItem {
  final Product product;
  final int quantity;
  final List<dynamic> bundleItems;

  GetCartItem({
    required this.product,
    required this.quantity,
    required this.bundleItems,
  });

  factory GetCartItem.fromJson(Map<String, dynamic> json) =>
      _$GetCartItemFromJson(json);

  Map<String, dynamic> toJson() => _$GetCartItemToJson(this);
}

@JsonSerializable()
class Product {
  final Price price;
  final Dimensions? dimensions;
  final List<MenuItem> menuItems;
  final List<SubMenuItem> subMenuItems;
  final List<dynamic> productTypes; // Changed to dynamic since these are IDs
  final List<dynamic> colors; // Changed to dynamic since these are IDs
  final List<dynamic> recipients; // Changed to dynamic since these are IDs
  final List<dynamic> bundleTypes; // Changed to dynamic since these are IDs
  final String? careTips;
  final bool freeDelivery;
  final bool premiumFlowers;
  @JsonKey(name: '_id')
  final String productId;
  final String? sku;
  final String? title;
  final String? description;
  final String? productType;
  final List<String> images;
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final List<Occasion> occasions;
  final dynamic brand; // Changed to dynamic since it can be string ID or object
  final bool expressDelivery;
  final int points;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> components;
  final List<BundleItem> bundleItems;
  @JsonKey(name: 'title_ar')
  final String? titleAr;
  @JsonKey(name: 'careTips_ar')
  final String? careTipsAr;
  @JsonKey(name: 'description_ar')
  final String? descriptionAr;

  Product({
    required this.price,
    this.dimensions,
    required this.menuItems,
    required this.subMenuItems,
    required this.productTypes,
    required this.colors,
    required this.recipients,
    required this.bundleTypes,
    this.careTips,
    required this.freeDelivery,
    required this.premiumFlowers,
    required this.productId,
    this.sku,
    this.title,
    this.description,
    this.productType,
    required this.images,
    required this.categories,
    required this.subCategories,
    required this.occasions,
    this.brand,
    required this.expressDelivery,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.components,
    required this.bundleItems,
    this.titleAr,
    this.careTipsAr,
    this.descriptionAr,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
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
  final double? width; // Made nullable
  final double? height; // Made nullable

  Dimensions({
    required this.width,
    required this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<String> subCategories;
  @JsonKey(name: 'categoryOrder')
  final int? categoryOrder;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.subCategories,
    this.categoryOrder,
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
  final String? imageUrl;
  final String category;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  SubCategory({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.category,
    this.nameAr,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  Occasion({
    required this.id,
    required this.name,
    this.imageUrl,
    this.nameAr,
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
  @JsonKey(name: 'cover_image_url')
  final String? coverImageUrl;
  @JsonKey(name: 'cover_image_url_ar')
  final String? coverImageUrlAr;
  @JsonKey(name: 'name_ar')
  final String? nameAr;

  Brand({
    required this.id,
    required this.name,
    this.imageUrl,
    this.coverImageUrl,
    this.coverImageUrlAr,
    this.nameAr,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BundleItem {
  final List<BundleCategory> categories;
  @JsonKey(name: '_id')
  final String id;

  BundleItem({
    required this.categories,
    required this.id,
  });

  factory BundleItem.fromJson(Map<String, dynamic> json) =>
      _$BundleItemFromJson(json);
  Map<String, dynamic> toJson() => _$BundleItemToJson(this);
}

@JsonSerializable()
class BundleCategory {
  @JsonKey(name: 'category_title')
  final String categoryTitle;
  @JsonKey(name: 'category_title_ar')
  final String categoryTitleAr;
  final List<String> items;
  final bool isRequired;
  @JsonKey(name: '_id')
  final String id;

  BundleCategory({
    required this.categoryTitle,
    required this.categoryTitleAr,
    required this.items,
    required this.isRequired,
    required this.id,
  });

  factory BundleCategory.fromJson(Map<String, dynamic> json) =>
      _$BundleCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BundleCategoryToJson(this);
}

@JsonSerializable()
class MenuItem {
  MenuItem();

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class SubMenuItem {
  SubMenuItem();

  factory SubMenuItem.fromJson(Map<String, dynamic> json) =>
      _$SubMenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$SubMenuItemToJson(this);
}
