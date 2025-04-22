// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => InvoiceItem(
      id: json['id'] as String,
      orderID: (json['orderID'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceDate: DateTime.parse(json['invoiceDate'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num).toInt(),
    );

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderID': instance.orderID,
      'invoiceDate': instance.invoiceDate.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'totalPrice': instance.totalPrice,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String,
      orderId: json['orderId'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      deliveryAreaCity: json['deliveryAreaCity'] as String?,
      products: json['products'] as List<dynamic>,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      deliveryCharges: (json['deliveryCharges'] as num?)?.toDouble(),
      vatPercentage: (json['vatPercentage'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String?,
      isSubscription: json['isSubscription'] as bool?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num?)?.toInt(),
      deliveryInfo: json['deliveryInfo'] == null
          ? null
          : DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>),
      giftCard: json['giftCard'] == null
          ? null
          : GiftCard.fromJson(json['giftCard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'userId': instance.userId,
      'email': instance.email,
      'status': instance.status,
      'deliveryAreaCity': instance.deliveryAreaCity,
      'products': instance.products,
      'subtotal': instance.subtotal,
      'deliveryCharges': instance.deliveryCharges,
      'vatPercentage': instance.vatPercentage,
      'total': instance.total,
      'paymentMethod': instance.paymentMethod,
      'isSubscription': instance.isSubscription,
      'date': instance.date?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'version': instance.version,
      'deliveryInfo': instance.deliveryInfo,
      'giftCard': instance.giftCard,
    };

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      shipping: json['shipping'] as String?,
      deliveryTime: json['deliveryTime'] == null
          ? null
          : DateTime.parse(json['deliveryTime'] as String),
      keepIdentitySecret: json['keepIdentitySecret'] as bool?,
      expressDelivery: json['expressDelivery'] as bool?,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'shipping': instance.shipping,
      'deliveryTime': instance.deliveryTime?.toIso8601String(),
      'keepIdentitySecret': instance.keepIdentitySecret,
      'expressDelivery': instance.expressDelivery,
    };

GiftCard _$GiftCardFromJson(Map<String, dynamic> json) => GiftCard(
      template: json['template'] as String?,
      to: json['to'] as String?,
      message: json['message'] as String?,
      link: json['link'] as String?,
      from: json['from'] as String?,
      handwriting: json['handwriting'] as bool?,
      signatureImageUrl: json['signature_image_url'] as String?,
      qrImageUrl: json['qr_image_url'] as String?,
    );

Map<String, dynamic> _$GiftCardToJson(GiftCard instance) => <String, dynamic>{
      'template': instance.template,
      'to': instance.to,
      'message': instance.message,
      'link': instance.link,
      'from': instance.from,
      'handwriting': instance.handwriting,
      'signature_image_url': instance.signatureImageUrl,
      'qr_image_url': instance.qrImageUrl,
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      id: json['_id'] as String,
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      '_id': instance.id,
    };
