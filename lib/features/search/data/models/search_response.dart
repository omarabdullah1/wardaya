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
  @JsonKey(defaultValue: [])
  final List<BundleItem> bundleItems;
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String productType;
  final List<String> images;
  @JsonKey(defaultValue: [])
  final List<Category> categories;
  @JsonKey(defaultValue: [])
  final List<SubCategory> subCategories;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;
  final int? points;
  final Brand? brand;
  @JsonKey(defaultValue: [])
  final List<BundleType> bundleTypes;
  final String? careTips;
  @JsonKey(defaultValue: [])
  final List<Color> colors;
  @JsonKey(defaultValue: false)
  final bool freeDelivery;
  @JsonKey(defaultValue: false)
  final bool isBundle;
  @JsonKey(defaultValue: [])
  final List<Occasion> occasions;
  @JsonKey(defaultValue: false)
  final bool premiumFlowers;
  @JsonKey(defaultValue: [])
  final List<ProductType> productTypes;
  @JsonKey(defaultValue: [])
  final List<Recipient> recipients;
  @JsonKey(defaultValue: [])
  final List<Component> components;
  @JsonKey(defaultValue: [])
  final List<String> menuItems;
  @JsonKey(defaultValue: [])
  final List<String> subMenuItems;

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
    required this.menuItems,
    required this.subMenuItems,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      // Create a safe copy of the JSON to handle various formats
      var safeJson = Map<String, dynamic>.from(json);

      // Handle price field which might be in a different format
      if (json['price'] is Map && json['price'] is! Map<String, dynamic>) {
        Map<dynamic, dynamic> rawPrice = json['price'] as Map;
        safeJson['price'] = {
          'total': rawPrice['total'] ?? 0,
          'currency': rawPrice['currency'] ?? 'SAR',
        };
      }

      // Handle dimensions field which might be in a different format
      if (json['dimensions'] is Map &&
          json['dimensions'] is! Map<String, dynamic>) {
        Map<dynamic, dynamic> rawDimensions = json['dimensions'] as Map;
        safeJson['dimensions'] = {
          'width': rawDimensions['width'],
          'height': rawDimensions['height'],
        };
      }

      // Handle categories that might be strings or objects
      if (json['categories'] is List) {
        List<dynamic> categories = json['categories'] as List;
        if (categories.isNotEmpty && categories[0] is String) {
          safeJson['categories'] = (categories)
              .map((e) => {'_id': e, 'name': '', 'subCategories': [], '__v': 0})
              .toList();
        }
      }

      // Handle subCategories that might be strings or objects
      if (json['subCategories'] is List) {
        List<dynamic> subCategories = json['subCategories'] as List;
        if (subCategories.isNotEmpty && subCategories[0] is String) {
          safeJson['subCategories'] = (subCategories)
              .map((e) => {'_id': e, 'name': '', 'category': '', '__v': 0})
              .toList();
        }
      }

      // Handle occasions that might be strings or objects
      if (json['occasions'] is List) {
        List<dynamic> occasions = json['occasions'] as List;
        if (occasions.isNotEmpty && occasions[0] is String) {
          safeJson['occasions'] =
              (occasions).map((e) => {'_id': e, 'name': '', '__v': 0}).toList();
        }
      }

      // Handle recipients that might be strings or objects
      if (json['recipients'] is List) {
        List<dynamic> recipients = json['recipients'] as List;
        if (recipients.isNotEmpty && recipients[0] is String) {
          safeJson['recipients'] = (recipients)
              .map((e) => {'_id': e, 'name': '', '__v': 0, 'images': []})
              .toList();
        }
      }

      // Handle bundleTypes that might be strings or objects
      if (json['bundleTypes'] is List) {
        List<dynamic> bundleTypes = json['bundleTypes'] as List;
        if (bundleTypes.isNotEmpty && bundleTypes[0] is String) {
          safeJson['bundleTypes'] = (bundleTypes)
              .map((e) => {'_id': e, 'name': '', '__v': 0})
              .toList();
        }
      }

      // Handle colors that might be strings or objects
      if (json['colors'] is List) {
        List<dynamic> colors = json['colors'] as List;
        if (colors.isNotEmpty && colors[0] is String) {
          safeJson['colors'] =
              (colors).map((e) => {'_id': e, 'name': '', '__v': 0}).toList();
        }
      }

      // Handle productTypes that might be strings or objects
      if (json['productTypes'] is List) {
        List<dynamic> productTypes = json['productTypes'] as List;
        if (productTypes.isNotEmpty && productTypes[0] is String) {
          safeJson['productTypes'] =
              (productTypes).map((e) => {'_id': e}).toList();
        }
      }

      // Handle bundleItems that might be strings or objects
      if (json['bundleItems'] is List) {
        List<dynamic> bundleItems = json['bundleItems'] as List;
        if (bundleItems.isNotEmpty) {
          if (bundleItems[0] is String) {
            // Convert string IDs to minimal BundleItems
            safeJson['bundleItems'] = (bundleItems)
                .map((e) => {'_id': e, 'title': '', 'sku': ''})
                .toList();
          } else if (bundleItems[0] is Map) {
            // Make sure each bundle item has the minimum required fields
            safeJson['bundleItems'] = (bundleItems).map((item) {
              Map<String, dynamic> safeItem =
                  Map<String, dynamic>.from(item as Map);
              if (!safeItem.containsKey('_id')) safeItem['_id'] = '';
              if (!safeItem.containsKey('title')) safeItem['title'] = '';
              if (!safeItem.containsKey('sku')) safeItem['sku'] = '';
              return safeItem;
            }).toList();
          }
        }
      }

      // Handle brand that might be a string or object
      if (json['brand'] is String) {
        safeJson['brand'] = {'_id': json['brand'], 'name': '', '__v': 0};
      }

      return _$ProductFromJson(safeJson);
    } catch (e) {
      // If parsing fails, return a minimal valid product
      return Product(
        id: json['_id'] as String? ?? '',
        sku: json['sku'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        productType: json['productType'] as String? ?? '',
        images: json['images'] is List
            ? (json['images'] as List)
                .map((e) => e.toString())
                .where((img) => !img.toString().startsWith('blob:'))
                .toList()
            : [],
        expressDelivery: json['expressDelivery'] as bool? ?? false,
        createdAt: DateTime.parse(
            json['createdAt'] as String? ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
        version: json['__v'] as int? ?? 0,
        price: Price(total: 0, currency: 'SAR'),
        bundleItems: [],
        categories: [],
        subCategories: [],
        bundleTypes: [],
        colors: [],
        occasions: [],
        productTypes: [],
        recipients: [],
        components: [],
        freeDelivery: false,
        isBundle: false,
        premiumFlowers: false,
        menuItems: [],
        subMenuItems: [],
      );
    }
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Helper method to get full image URLs
  List<String> get fullImageUrls => images.map((image) {
        if (image.startsWith('http')) return image;
        if (image.startsWith('blob:')) return ''; // Skip blob URLs
        return 'https://wardaya-tan.vercel.app$image'; // Correct base URL
      }).toList();
}

@JsonSerializable()
class BundleItem {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String sku;

  BundleItem({
    required this.id,
    required this.title,
    required this.sku,
  });

  factory BundleItem.fromJson(Map<String, dynamic> json) =>
      _$BundleItemFromJson(json);

  Map<String, dynamic> toJson() => _$BundleItemToJson(this);
}

@JsonSerializable()
class Price {
  final double total;
  final String currency;

  Price({required this.total, required this.currency});

  factory Price.fromJson(Map<String, dynamic> json) {
    // Handle total field which can be int or double
    double totalValue;
    if (json['total'] is int) {
      totalValue = (json['total'] as int).toDouble();
    } else {
      totalValue = (json['total'] as num).toDouble();
    }

    return Price(
      total: totalValue,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Dimensions {
  final double? width;
  final double? height;

  Dimensions({this.width, this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    // Handle width and height fields which can be int, double, or null
    double? widthValue;
    if (json['width'] is int) {
      widthValue = (json['width'] as int).toDouble();
    } else if (json['width'] is double) {
      widthValue = json['width'] as double;
    } else if (json['width'] is num) {
      widthValue = (json['width'] as num).toDouble();
    }

    double? heightValue;
    if (json['height'] is int) {
      heightValue = (json['height'] as int).toDouble();
    } else if (json['height'] is double) {
      heightValue = json['height'] as double;
    } else if (json['height'] is num) {
      heightValue = (json['height'] as num).toDouble();
    }

    return Dimensions(
      width: widthValue,
      height: heightValue,
    );
  }

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? imageUrl;
  @JsonKey(defaultValue: [])
  final List<String> subCategories;
  @JsonKey(name: '__v')
  final int version;
  final int? categoryOrder;
  final String? nameAr;

  Category({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.subCategories,
    required this.version,
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
  final String? nameAr;
  @JsonKey(name: '__v')
  final int version;

  Color({
    required this.id,
    required this.name,
    this.nameAr,
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
  final String? nameAr;
  @JsonKey(name: '__v')
  final int version;

  Occasion({
    required this.id,
    required this.name,
    this.imageUrl,
    this.nameAr,
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
  final String? name;

  ProductType({
    required this.id,
    this.name,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? nameAr;
  @JsonKey(name: '__v')
  final int version;
  @JsonKey(defaultValue: [])
  final List<String> images;

  Recipient({
    required this.id,
    required this.name,
    this.nameAr,
    required this.version,
    required this.images,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    try {
      return _$RecipientFromJson(json);
    } catch (e) {
      // Handle case where images is null or not a list
      return Recipient(
        id: json['_id'] as String,
        name: json['name'] as String,
        nameAr: json['name_ar'] as String?,
        version: (json['__v'] as num).toInt(),
        images: json['images'] == null
            ? []
            : (json['images'] is List
                ? (json['images'] as List).map((e) => e.toString()).toList()
                : []),
      );
    }
  }

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
