// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersRequestBody _$MyOrdersRequestBodyFromJson(Map<String, dynamic> json) =>
    MyOrdersRequestBody(
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      search: json['search'] as String?,
    );
