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
  });

  Map<String, dynamic> toJson() => _$SearchRequestBodyToJson(this);
  factory SearchRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestBodyFromJson(json);
}
