// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersResponse _$MyOrdersResponseFromJson(Map<String, dynamic> json) =>
    MyOrdersResponse(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalOrders: (json['totalOrders'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$MyOrdersResponseToJson(MyOrdersResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'limit': instance.limit,
      'totalOrders': instance.totalOrders,
      'totalPages': instance.totalPages,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      deliveryAreaCity: json['deliveryAreaCity'] as String,
      deliveryInfo:
          DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>),
      products: Order._productsFromJson(json['products'] as List),
      subtotal: json['subtotal'] as num,
      deliveryCharges: json['deliveryCharges'] as num,
      vatPercentage: json['vatPercentage'] as num,
      total: json['total'] as num,
      paymentMethod: json['paymentMethod'] as String,
      giftCard: json['giftCard'] == null
          ? null
          : GiftCard.fromJson(json['giftCard'] as Map<String, dynamic>),
      appliedPromoCode: json['appliedPromoCode'] == null
          ? null
          : PromoCode.fromJson(
              json['appliedPromoCode'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      customStatusSort: (json['customStatusSort'] as num).toInt(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'orderId': instance.orderId,
      'userId': instance.userId,
      'email': instance.email,
      'status': instance.status,
      'deliveryAreaCity': instance.deliveryAreaCity,
      'deliveryInfo': instance.deliveryInfo.toJson(),
      'products': instance.products.map((e) => e.toJson()).toList(),
      'subtotal': instance.subtotal,
      'deliveryCharges': instance.deliveryCharges,
      'vatPercentage': instance.vatPercentage,
      'total': instance.total,
      'paymentMethod': instance.paymentMethod,
      'giftCard': instance.giftCard?.toJson(),
      'appliedPromoCode': instance.appliedPromoCode?.toJson(),
      'date': instance.date.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'customStatusSort': instance.customStatusSort,
    };

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      productId: json['productId'] == null
          ? null
          : Product.fromJson(json['productId'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: json['price'] as num? ?? 0,
      id: json['_id'] as String? ?? '',
      bundleItems: json['bundleItems'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId?.toJson(),
      'quantity': instance.quantity,
      'price': instance.price,
      '_id': instance.id,
      'bundleItems': instance.bundleItems,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String?,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      occasions: (json['occasions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      brand: json['brand'] as String?,
      expressDelivery: json['expressDelivery'] as bool? ?? false,
      points: (json['points'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'price': instance.price.toJson(),
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'occasions': instance.occasions,
      'brand': instance.brand,
      'expressDelivery': instance.expressDelivery,
      'points': instance.points,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: json['total'] as num,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
      name: json['name'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      shipping: ShippingInfo.fromJson(json['shipping'] as Map<String, dynamic>),
      deliveryTime: DateTime.parse(json['deliveryTime'] as String),
      keepIdentitySecret: json['keepIdentitySecret'] as bool,
      expressDelivery: json['expressDelivery'] as bool,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'shipping': instance.shipping.toJson(),
      'deliveryTime': instance.deliveryTime.toIso8601String(),
      'keepIdentitySecret': instance.keepIdentitySecret,
      'expressDelivery': instance.expressDelivery,
    };

ShippingInfo _$ShippingInfoFromJson(Map<String, dynamic> json) => ShippingInfo(
      id: json['_id'] as String,
      userId: json['userId'] as String? ?? '',
      recipientArea: json['recipientArea'] as String,
      recipientAddress: json['recipientAddress'] as String,
      extraAddressDetails: json['extraAddressDetails'] as String? ?? '',
      latitude: json['latitude'] as num? ?? 0,
      longitude: json['longitude'] as num? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShippingInfoToJson(ShippingInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'recipientArea': instance.recipientArea,
      'recipientAddress': instance.recipientAddress,
      'extraAddressDetails': instance.extraAddressDetails,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

GiftCard _$GiftCardFromJson(Map<String, dynamic> json) => GiftCard(
      template: json['template'] == null
          ? null
          : GiftCardTemplate.fromJson(json['template'] as Map<String, dynamic>),
      from: json['from'] as String?,
      to: json['to'] as String?,
      message: json['message'] as String?,
      link: json['link'] as String?,
      handwriting: json['handwriting'] as bool?,
      signatureImageUrl: json['signature_image_url'] as String?,
      qrImageUrl: json['qr_image_url'] as String?,
    );

Map<String, dynamic> _$GiftCardToJson(GiftCard instance) => <String, dynamic>{
      'template': instance.template?.toJson(),
      'from': instance.from,
      'to': instance.to,
      'message': instance.message,
      'link': instance.link,
      'handwriting': instance.handwriting,
      'signature_image_url': instance.signatureImageUrl,
      'qr_image_url': instance.qrImageUrl,
    };

GiftCardTemplate _$GiftCardTemplateFromJson(Map<String, dynamic> json) =>
    GiftCardTemplate(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
      occasions:
          (json['occasions'] as List<dynamic>).map((e) => e as String).toList(),
      suggestedMessages: (json['suggested_messages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GiftCardTemplateToJson(GiftCardTemplate instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price.toJson(),
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
      'occasions': instance.occasions,
      'suggested_messages': instance.suggestedMessages,
    };

PromoCode _$PromoCodeFromJson(Map<String, dynamic> json) => PromoCode(
      id: json['_id'] as String,
      name: json['name'] as String,
      discountPercentage: json['discountPercentage'] as num,
      expireDate: DateTime.parse(json['expireDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$PromoCodeToJson(PromoCode instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'discountPercentage': instance.discountPercentage,
      'expireDate': instance.expireDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };
