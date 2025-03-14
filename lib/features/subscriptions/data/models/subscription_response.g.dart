// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionResponse _$SubscriptionResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      userId: json['userId'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      subscriptionPlan: json['subscription_plan'] as String,
      deliveryFrequency: json['delivery_frequency'] as String,
      duration: Duration.fromJson(json['duration'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$SubscriptionResponseToJson(
        SubscriptionResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'userId': instance.userId,
      'product': instance.product,
      'subscription_plan': instance.subscriptionPlan,
      'delivery_frequency': instance.deliveryFrequency,
      'duration': instance.duration,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      id: json['_id'] as String,
      sku: json['sku'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      productType: json['productType'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      expressDelivery: json['expressDelivery'] as bool,
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'price': instance.price,
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'expressDelivery': instance.expressDelivery,
      'points': instance.points,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: (json['total'] as num).toInt(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

Duration _$DurationFromJson(Map<String, dynamic> json) => Duration(
      id: json['_id'] as String,
      duration: json['duration'] as String,
      price: (json['price'] as num).toInt(),
      discountedPrice: (json['discounted_price'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DurationToJson(Duration instance) => <String, dynamic>{
      '_id': instance.id,
      'duration': instance.duration,
      'price': instance.price,
      'discounted_price': instance.discountedPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
