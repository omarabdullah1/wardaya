import 'package:json_annotation/json_annotation.dart';

part 'filter_data_body.g.dart';

@JsonSerializable()
class FilterDataBody {
  final String? category;
  final String? subCategory;
  final String? brand;
  final String? occasion;
  final String? color;
  final String? recipients;
  final String? bundleTypes;
  final String? priceRange;

  FilterDataBody({
    this.category,
    this.subCategory,
    this.brand,
    this.occasion,
    this.color,
    this.recipients,
    this.bundleTypes,
    this.priceRange,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Only include non-null, non-empty fields
    if (category != null && category!.isNotEmpty) data['category'] = category;
    if (subCategory != null && subCategory!.isNotEmpty) {
      data['subCategory'] = subCategory;
    }
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

    return data;
  }

  factory FilterDataBody.fromJson(Map<String, dynamic> json) =>
      _$FilterDataBodyFromJson(json);
}
