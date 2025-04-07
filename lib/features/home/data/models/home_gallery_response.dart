import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

part 'home_gallery_response.g.dart';

@JsonSerializable()
class GalleryItem {
  @JsonKey(name: "_id")
  final String id;
  final String? brand; // Nullable
  final String? occasion; // Nullable
  final String? recipient; // Nullable
  final String? subCategory; // Nullable
  final String textOnImage;
  final String textOnButton;
  @JsonKey(name: "image_url")
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

  factory GalleryResponse.fromJson(dynamic json) {
    log("Parsing JSON: $json"); // Debugging line
    if (json is List) {
      try {
        return GalleryResponse(
          items: json
              .map((item) => GalleryItem.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (e) {
        log("Error parsing gallery items: $e, JSON: $json");
        rethrow;
      }
    } else {
      throw FormatException('Expected a list but got: $json');
    }
  }

  // Make this method static
  static GalleryResponse convert(dynamic value) {
    return GalleryResponse.fromJson(value);
  }

  Map<String, dynamic> toJson() => _$GalleryResponseToJson(this);
}
