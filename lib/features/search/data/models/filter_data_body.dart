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

  Map<String, dynamic> toJson() => _$FilterDataBodyToJson(this);
  factory FilterDataBody.fromJson(Map<String, dynamic> json) =>
      _$FilterDataBodyFromJson(json);
}
