// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => InvoiceItem(
      id: json['_id'] as String,
      orderID: json['orderID'] as List<dynamic>? ?? [],
      invoiceDate: DateTime.parse(json['invoiceDate'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$InvoiceItemToJson(InvoiceItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderID': instance.orderID,
      'invoiceDate': instance.invoiceDate.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'totalPrice': instance.totalPrice,
      'currency': instance.currency,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

InvoicesResponse _$InvoicesResponseFromJson(Map<String, dynamic> json) =>
    InvoicesResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoicesResponseToJson(InvoicesResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
