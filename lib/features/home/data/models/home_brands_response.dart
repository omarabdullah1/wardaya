import 'package:json_annotation/json_annotation.dart';

part 'home_brands_response.g.dart';

@JsonSerializable()
class HomeBrandsResponse {
  final List<Brand> brands;

  HomeBrandsResponse({required this.brands});

  factory HomeBrandsResponse.fromJson(List<Brand> json) {
    return HomeBrandsResponse(
      brands: json
          .map((item) => Brand.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$HomeBrandsResponseToJson(this);
}

@JsonSerializable()
class Brand {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: '__v', defaultValue: 0)
  final int version;
  @JsonKey(name: 'cover_image_url')
  final String coverImageUrl;

  Brand({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.version,
    required this.coverImageUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
