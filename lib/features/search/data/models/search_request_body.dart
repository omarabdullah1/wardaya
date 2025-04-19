import 'package:json_annotation/json_annotation.dart';

part 'search_request_body.g.dart';

@JsonSerializable()
class SearchRequestBody {
  final int limit;
  final int page;
  final String? category;
  final String? subCategory;
  final String? search;
  final String? brand;
  final String? occasion;
  final String? color;
  final String? recipients;
  final String? bundleTypes;
  final String? priceRange;
  final String? subMenuItems;
  final bool? expressDelivery;

  SearchRequestBody({
    required this.limit,
    required this.page,
    this.category,
    this.subCategory,
    this.search,
    this.brand,
    this.occasion,
    this.color,
    this.recipients,
    this.bundleTypes,
    this.priceRange,
    this.subMenuItems,
    this.expressDelivery,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Always include required fields
    data['limit'] = limit;
    data['page'] = page;

    // Only include non-null, non-empty optional fields
    if (category != null && category!.isNotEmpty) data['category'] = category;
    if (subCategory != null && subCategory!.isNotEmpty) {
      data['subCategory'] = subCategory;
    }
    if (search != null && search!.isNotEmpty) data['search'] = search;
    if (brand != null && brand!.isNotEmpty) data['brand'] = brand;
    if (occasion != null && occasion!.isNotEmpty) data['occasion'] = occasion;
    if (color != null && color!.isNotEmpty) data['color'] = color;
    if (recipients != null && recipients!.isNotEmpty) {
      data['recipients'] = recipients;
    }
    if (bundleTypes != null && bundleTypes!.isNotEmpty) {
      data['bundleTypes'] = bundleTypes;
    }
    if (priceRange != null && priceRange!.isNotEmpty) {
      data['priceRange'] = priceRange;
    }
    if (expressDelivery != null) data['expressDelivery'] = expressDelivery;

    return data;
  }

  factory SearchRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestBodyFromJson(json);
}
