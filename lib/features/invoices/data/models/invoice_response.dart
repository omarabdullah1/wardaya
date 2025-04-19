import 'package:json_annotation/json_annotation.dart';

part 'invoice_response.g.dart';

@JsonSerializable()
class InvoiceItem {
  final String id;
  final List<OrderItem> orderID;
  final DateTime invoiceDate;
  final String name;
  final String email;
  final String phoneNumber;
  final double totalPrice;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  InvoiceItem({
    required this.id,
    required this.orderID,
    required this.invoiceDate,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];

    if (json.containsKey('orderID') && json['orderID'] is List) {
      orderItems = (json['orderID'] as List)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return InvoiceItem(
      id: json['_id'],
      orderID: orderItems,
      invoiceDate: DateTime.parse(json['invoiceDate']),
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? '',
      totalPrice: (json['totalPrice'] as num).toDouble(),
      currency: json['currency'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderID': orderID.map((item) => item.toJson()).toList(),
      'invoiceDate': invoiceDate.toIso8601String(),
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'totalPrice': totalPrice,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

@JsonSerializable()
class OrderItem {
  final String id;
  final String? orderId;
  final String? userId;
  final String? email;
  final String? status;
  final String? deliveryAreaCity;
  final List<dynamic> products;
  final double? subtotal;
  final double? deliveryCharges;
  final double? vatPercentage;
  final double? total;
  final String? paymentMethod;
  final bool? isSubscription;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;
  final DeliveryInfo? deliveryInfo;
  final GiftCard? giftCard;

  OrderItem({
    required this.id,
    this.orderId,
    this.userId,
    this.email,
    this.status,
    this.deliveryAreaCity,
    required this.products,
    this.subtotal,
    this.deliveryCharges,
    this.vatPercentage,
    this.total,
    this.paymentMethod,
    this.isSubscription,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.deliveryInfo,
    this.giftCard,
  });

  factory OrderItem.empty() {
    return OrderItem(
      id: '',
      products: [],
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    DeliveryInfo? deliveryInfoObj;
    if (json.containsKey('deliveryInfo') && json['deliveryInfo'] is Map) {
      deliveryInfoObj =
          DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>);
    }

    GiftCard? giftCardObj;
    if (json.containsKey('giftCard') && json['giftCard'] is Map) {
      giftCardObj = GiftCard.fromJson(json['giftCard'] as Map<String, dynamic>);
    }

    return OrderItem(
      id: json['_id'],
      orderId: json['orderId'],
      userId: json['userId'],
      email: json['email'],
      status: json['status'],
      deliveryAreaCity: json['deliveryAreaCity'],
      products: json['products'] is List ? json['products'] : [],
      subtotal: json['subtotal'] != null
          ? (json['subtotal'] as num).toDouble()
          : null,
      deliveryCharges: json['deliveryCharges'] != null
          ? (json['deliveryCharges'] as num).toDouble()
          : null,
      vatPercentage: json['vatPercentage'] != null
          ? (json['vatPercentage'] as num).toDouble()
          : null,
      total: json['total'] != null ? (json['total'] as num).toDouble() : null,
      paymentMethod: json['paymentMethod'],
      isSubscription: json['isSubscription'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      version: json['__v'],
      deliveryInfo: deliveryInfoObj,
      giftCard: giftCardObj,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'products': products,
    };

    if (orderId != null) data['orderId'] = orderId;
    if (userId != null) data['userId'] = userId;
    if (email != null) data['email'] = email;
    if (status != null) data['status'] = status;
    if (deliveryAreaCity != null) data['deliveryAreaCity'] = deliveryAreaCity;
    if (subtotal != null) data['subtotal'] = subtotal;
    if (deliveryCharges != null) data['deliveryCharges'] = deliveryCharges;
    if (vatPercentage != null) data['vatPercentage'] = vatPercentage;
    if (total != null) data['total'] = total;
    if (paymentMethod != null) data['paymentMethod'] = paymentMethod;
    if (isSubscription != null) data['isSubscription'] = isSubscription;
    if (date != null) data['date'] = date!.toIso8601String();
    if (createdAt != null) data['createdAt'] = createdAt!.toIso8601String();
    if (updatedAt != null) data['updatedAt'] = updatedAt!.toIso8601String();
    if (version != null) data['__v'] = version;
    if (deliveryInfo != null) data['deliveryInfo'] = deliveryInfo!.toJson();
    if (giftCard != null) data['giftCard'] = giftCard!.toJson();

    return data;
  }
}

@JsonSerializable()
class DeliveryInfo {
  final String? name;
  final String? phone;
  final String? countryCode;
  final String? shipping;
  final DateTime? deliveryTime;
  final bool? keepIdentitySecret;
  final bool? expressDelivery;

  DeliveryInfo({
    this.name,
    this.phone,
    this.countryCode,
    this.shipping,
    this.deliveryTime,
    this.keepIdentitySecret,
    this.expressDelivery,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      name: json['name'],
      phone: json['phone'],
      countryCode: json['countryCode'],
      shipping: json['shipping'],
      deliveryTime: json['deliveryTime'] != null
          ? DateTime.parse(json['deliveryTime'])
          : null,
      keepIdentitySecret: json['keepIdentitySecret'],
      expressDelivery: json['expressDelivery'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (countryCode != null) data['countryCode'] = countryCode;
    if (shipping != null) data['shipping'] = shipping;
    if (deliveryTime != null) {
      data['deliveryTime'] = deliveryTime!.toIso8601String();
    }
    if (keepIdentitySecret != null) {
      data['keepIdentitySecret'] = keepIdentitySecret;
    }
    if (expressDelivery != null) data['expressDelivery'] = expressDelivery;

    return data;
  }
}

@JsonSerializable()
class GiftCard {
  final String? template;
  final String? to;
  final String? message;
  final String? link;
  final String? from;
  final bool? handwriting;
  @JsonKey(name: 'signature_image_url')
  final String? signatureImageUrl;
  @JsonKey(name: 'qr_image_url')
  final String? qrImageUrl;

  GiftCard({
    this.template,
    this.to,
    this.message,
    this.link,
    this.from,
    this.handwriting,
    this.signatureImageUrl,
    this.qrImageUrl,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      template: json['template'],
      to: json['to'],
      message: json['message'],
      link: json['link'],
      from: json['from'],
      handwriting: json['handwriting'],
      signatureImageUrl: json['signature_image_url'],
      qrImageUrl: json['qr_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (template != null) data['template'] = template;
    if (to != null) data['to'] = to;
    if (message != null) data['message'] = message;
    if (link != null) data['link'] = link;
    if (from != null) data['from'] = from;
    if (handwriting != null) data['handwriting'] = handwriting;
    if (signatureImageUrl != null) {
      data['signature_image_url'] = signatureImageUrl;
    }
    if (qrImageUrl != null) data['qr_image_url'] = qrImageUrl;

    return data;
  }
}

class InvoicesResponse {
  final List<InvoiceItem> items;

  InvoicesResponse({required this.items});

  factory InvoicesResponse.fromJson(dynamic json) {
    if (json is List) {
      return InvoicesResponse(
        items: json
            .map((item) => InvoiceItem.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else if (json is Map<String, dynamic> && json.containsKey('items')) {
      final List<dynamic> jsonItems = json['items'] as List<dynamic>;
      return InvoicesResponse(
        items: jsonItems
            .map((item) => InvoiceItem.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } else {
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
