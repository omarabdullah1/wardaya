import 'package:json_annotation/json_annotation.dart';

part 'home_gallery_response.g.dart';

@JsonSerializable()
class GalleryItem {
  @JsonKey(name: "_id")
  final String id;
  final String? brand;
  final String? occasion;
  final String? recipient;
  final String? subCategory;
  final String textOnImage;
  final String textOnButton;
  final String imageUrl;

  GalleryItem({
    required this.id,
    this.brand,
    this.occasion,
    this.recipient,
    this.subCategory,
    required this.textOnImage,
    required this.textOnButton,
    required this.imageUrl,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryItemToJson(this);
}

@JsonSerializable()
class GalleryResponse {
  final List<GalleryItem> items;

  GalleryResponse({required this.items});

  factory GalleryResponse.fromJson(Map<String, dynamic> json) =>
      _$GalleryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryResponseToJson(this);
}
