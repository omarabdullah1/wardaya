import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

part 'subscription_plans_response.g.dart';

@JsonSerializable()
class SubscriptionPlan {
  final String id;
  final List<ProductItem> products;
  final double pricePerDelivery;
  final List<String> imagesUrl;
  final String name;
  final String miniDescription;
  final String longDescription;

  SubscriptionPlan({
    required this.id,
    required this.products,
    required this.pricePerDelivery,
    required this.imagesUrl,
    required this.name,
    required this.miniDescription,
    required this.longDescription,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    List<ProductItem> productItems = [];

    if (json.containsKey('products') && json['products'] is List) {
      productItems = (json['products'] as List)
          .map((item) => ProductItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return SubscriptionPlan(
      id: json['_id'],
      products: productItems,
      pricePerDelivery: (json['pricePerDelivery'] as num).toDouble(),
      imagesUrl: (json['images_url'] as List).map((e) => e as String).toList(),
      name: json['name'],
      miniDescription: json['miniDescription'],
      longDescription: json['longDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products.map((item) => item.toJson()).toList(),
      'pricePerDelivery': pricePerDelivery,
      'images_url': imagesUrl,
      'name': name,
      'miniDescription': miniDescription,
      'longDescription': longDescription,
    };
  }
}

@JsonSerializable()
class ProductItem {
  final Price price;
  final Dimensions dimensions;
  final List<dynamic> menuItems;
  final List<dynamic> subMenuItems;
  final String id;
  final String sku;
  final String title;
  final String description;
  final String productType;
  final List<String> images;
  final List<String> categories;
  final List<String> subCategories;
  final bool expressDelivery;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final int? points;
  final String? brand;
  final List<dynamic> bundleTypes;
  final String? careTips;
  final List<String>? colors;
  final bool? freeDelivery;
  final bool? isBundle;
  final List<String>? occasions;
  final bool? premiumFlowers;
  final List<String>? productTypes;
  final List<String>? recipients;
  final String? titleAr;
  final String? descriptionAr;
  final String? careTipsAr;
  final List<dynamic>? components;
  final List<dynamic>? bundleItems;

  ProductItem({
    required this.price,
    required this.dimensions,
    required this.menuItems,
    required this.subMenuItems,
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
    this.colors,
    this.freeDelivery,
    this.isBundle,
    this.occasions,
    this.premiumFlowers,
    this.productTypes,
    this.recipients,
    this.titleAr,
    this.descriptionAr,
    this.careTipsAr,
    this.components,
    this.bundleItems,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      dimensions:
          Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      menuItems: json['menuItems'] is List ? json['menuItems'] : [],
      subMenuItems: json['subMenuItems'] is List ? json['subMenuItems'] : [],
      id: json['_id'],
      sku: json['sku'],
      title: json['title'],
      description: json['description'],
      productType: json['productType'],
      images: (json['images'] as List).map((e) => e as String).toList(),
      categories: (json['categories'] as List).map((e) => e as String).toList(),
      subCategories:
          (json['subCategories'] as List).map((e) => e as String).toList(),
      expressDelivery: json['expressDelivery'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
      points: json['points'],
      brand: json['brand'],
      bundleTypes: json['bundleTypes'] is List ? json['bundleTypes'] : [],
      careTips: json['careTips'],
      colors: json['colors'] is List
          ? (json['colors'] as List).map((e) => e as String).toList()
          : null,
      freeDelivery: json['freeDelivery'],
      isBundle: json['isBundle'],
      occasions: json['occasions'] is List
          ? (json['occasions'] as List).map((e) => e as String).toList()
          : null,
      premiumFlowers: json['premiumFlowers'],
      productTypes: json['productTypes'] is List
          ? (json['productTypes'] as List).map((e) => e as String).toList()
          : null,
      recipients: json['recipients'] is List
          ? (json['recipients'] as List).map((e) => e as String).toList()
          : null,
      titleAr: json['title_ar'],
      descriptionAr: json['description_ar'],
      careTipsAr: json['careTips_ar'],
      components: json['components'] is List ? json['components'] : null,
      bundleItems: json['bundleItems'] is List ? json['bundleItems'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'price': price.toJson(),
      'dimensions': dimensions.toJson(),
      'menuItems': menuItems,
      'subMenuItems': subMenuItems,
      '_id': id,
      'sku': sku,
      'title': title,
      'description': description,
      'productType': productType,
      'images': images,
      'categories': categories,
      'subCategories': subCategories,
      'expressDelivery': expressDelivery,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
      'bundleTypes': bundleTypes,
    };

    if (points != null) data['points'] = points;
    if (brand != null) data['brand'] = brand;
    if (careTips != null) data['careTips'] = careTips;
    if (colors != null) data['colors'] = colors;
    if (freeDelivery != null) data['freeDelivery'] = freeDelivery;
    if (isBundle != null) data['isBundle'] = isBundle;
    if (occasions != null) data['occasions'] = occasions;
    if (premiumFlowers != null) data['premiumFlowers'] = premiumFlowers;
    if (productTypes != null) data['productTypes'] = productTypes;
    if (recipients != null) data['recipients'] = recipients;
    if (titleAr != null) data['title_ar'] = titleAr;
    if (descriptionAr != null) data['description_ar'] = descriptionAr;
    if (careTipsAr != null) data['careTips_ar'] = careTipsAr;
    if (components != null) data['components'] = components;
    if (bundleItems != null) data['bundleItems'] = bundleItems;

    return data;
  }
}

@JsonSerializable()
class Price {
  final double total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      total: (json['total'] as num).toDouble(),
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'currency': currency,
    };
  }
}

@JsonSerializable()
class Dimensions {
  final double? width;
  final double? height;

  Dimensions({
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'] != null ? (json['width'] as num).toDouble() : null,
      height:
          json['height'] != null ? (json['height'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (width != null) data['width'] = width;
    if (height != null) data['height'] = height;
    return data;
  }
}

class SubscriptionPlansResponse {
  final List<SubscriptionPlan> plans;

  SubscriptionPlansResponse({required this.plans});

  factory SubscriptionPlansResponse.fromJson(dynamic json) {
    if (json is List) {
      try {
        return SubscriptionPlansResponse(
          plans: json
              .map((item) =>
                  SubscriptionPlan.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (e) {
        log('Error parsing subscription plan list: $e');
        // Return empty list if there's an error parsing
        return SubscriptionPlansResponse(plans: []);
      }
    } else if (json is Map<String, dynamic> && json.containsKey('plans')) {
      try {
        final List<dynamic> jsonPlans = json['plans'] as List<dynamic>;
        return SubscriptionPlansResponse(
          plans: jsonPlans
              .map((item) =>
                  SubscriptionPlan.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (e) {
        log('Error parsing subscription plan object: $e');
        // Return empty list if there's an error parsing
        return SubscriptionPlansResponse(plans: []);
      }
    } else {
      // Return empty list for unexpected format instead of throwing exception
      log('Unexpected JSON format: $json');
      return SubscriptionPlansResponse(plans: []);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'plans': plans.map((plan) => plan.toJson()).toList(),
    };
  }
}
