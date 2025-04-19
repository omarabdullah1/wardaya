import 'package:json_annotation/json_annotation.dart';

part 'my_orders_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MyOrdersResponse {
  final List<Order> orders;
  final int page;
  final int limit;
  final int totalOrders;
  final int totalPages;

  MyOrdersResponse({
    required this.orders,
    required this.page,
    required this.limit,
    required this.totalOrders,
    required this.totalPages,
  });

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrdersResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: '_id')
  final String id;
  final String orderId;
  final String userId;
  final String email;
  final String status;
  final String deliveryAreaCity;
  final DeliveryInfo deliveryInfo;
  @JsonKey(fromJson: _productsFromJson)
  final List<OrderProduct> products;
  final num subtotal;
  final num deliveryCharges;
  final num vatPercentage;
  final num total;
  final String paymentMethod;
  @JsonKey(defaultValue: null)
  final GiftCard? giftCard;
  @JsonKey(defaultValue: null)
  final PromoCode? appliedPromoCode;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int customStatusSort;

  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.email,
    required this.status,
    required this.deliveryAreaCity,
    required this.deliveryInfo,
    required this.products,
    required this.subtotal,
    required this.deliveryCharges,
    required this.vatPercentage,
    required this.total,
    required this.paymentMethod,
    this.giftCard,
    this.appliedPromoCode,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.customStatusSort,
  });

  static List<OrderProduct> _productsFromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return [OrderProduct.empty()];
    }

    final products = json.map((product) {
      if (product is Map<String, dynamic> && product.isNotEmpty) {
        return OrderProduct.fromJson(product);
      }
      return OrderProduct.empty();
    }).toList();

    return products.isEmpty ? [OrderProduct.empty()] : products;
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderProduct {
  @JsonKey(defaultValue: null)
  final Product? productId;
  @JsonKey(defaultValue: 1)
  final int quantity;
  @JsonKey(defaultValue: 0)
  final num price;
  @JsonKey(name: '_id', defaultValue: '')
  final String id;
  @JsonKey(defaultValue: [])
  final List<dynamic> bundleItems;

  OrderProduct({
    this.productId,
    required this.quantity,
    required this.price,
    required this.id,
    this.bundleItems = const [],
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return OrderProduct.empty();
    }

    try {
      final productIdJson = json['productId'];
      Product? product;

      if (productIdJson != null && productIdJson is Map<String, dynamic>) {
        product = Product.fromJson(productIdJson);
      }

      return OrderProduct(
        productId: product,
        quantity: json['quantity'] as int? ?? 1,
        price: json['price'] as num? ?? 0,
        id: json['_id'] as String? ?? '',
        bundleItems: json['bundleItems'] as List<dynamic>? ?? const [],
      );
    } catch (e) {
      return OrderProduct.empty();
    }
  }

  Map<String, dynamic> toJson() => _$OrderProductToJson(this);

  factory OrderProduct.empty() => OrderProduct(
        productId: null,
        quantity: 1,
        price: 0,
        id: '',
      );
}

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String sku;
  final String title;
  final String description;
  final String? productType;
  final Price price;
  @JsonKey(defaultValue: [])
  final List<String> images;
  @JsonKey(defaultValue: [])
  final List<String> categories;
  @JsonKey(defaultValue: [])
  final List<String> subCategories;
  @JsonKey(defaultValue: [])
  final List<String>? occasions;
  final String? brand;
  @JsonKey(defaultValue: false)
  final bool expressDelivery;
  final int? points;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.description,
    this.productType,
    required this.price,
    this.images = const [],
    this.categories = const [],
    this.subCategories = const [],
    this.occasions,
    this.brand,
    this.expressDelivery = false,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Price {
  final num total;
  final String currency;

  Price({
    required this.total,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeliveryInfo {
  final String name;
  final String phone;
  final String countryCode;
  final ShippingInfo shipping;
  final DateTime deliveryTime;
  final bool keepIdentitySecret;
  final bool expressDelivery;

  DeliveryInfo({
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.shipping,
    required this.deliveryTime,
    required this.keepIdentitySecret,
    required this.expressDelivery,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) =>
      _$DeliveryInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ShippingInfo {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(defaultValue: '')
  final String? userId;
  final String recipientArea;
  final String recipientAddress;
  @JsonKey(defaultValue: '')
  final String extraAddressDetails;
  @JsonKey(defaultValue: 0)
  final num latitude;
  @JsonKey(defaultValue: 0)
  final num longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  ShippingInfo({
    required this.id,
    this.userId,
    required this.recipientArea,
    required this.recipientAddress,
    required this.extraAddressDetails,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    this.version,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiftCard {
  final GiftCardTemplate? template;
  final String? from;
  final String? to;
  final String? message;
  final String? link;
  final bool? handwriting;
  @JsonKey(name: 'signature_image_url')
  final String? signatureImageUrl;
  @JsonKey(name: 'qr_image_url')
  final String? qrImageUrl;

  GiftCard({
    this.template,
    this.from,
    this.to,
    this.message,
    this.link,
    this.handwriting,
    this.signatureImageUrl,
    this.qrImageUrl,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) =>
      _$GiftCardFromJson(json);
  Map<String, dynamic> toJson() => _$GiftCardToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiftCardTemplate {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final Price price;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int? version;
  final List<String> occasions;
  @JsonKey(name: 'suggested_messages')
  final List<String> suggestedMessages;

  GiftCardTemplate({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.version,
    required this.occasions,
    required this.suggestedMessages,
  });

  factory GiftCardTemplate.fromJson(Map<String, dynamic> json) =>
      _$GiftCardTemplateFromJson(json);
  Map<String, dynamic> toJson() => _$GiftCardTemplateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PromoCode {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final num discountPercentage;
  final DateTime expireDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;

  PromoCode({
    required this.id,
    required this.name,
    required this.discountPercentage,
    required this.expireDate,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeFromJson(json);
  Map<String, dynamic> toJson() => _$PromoCodeToJson(this);
}
