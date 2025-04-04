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

  // Custom fromJson that handles both List and Map responses
  factory GalleryResponse.fromJson(dynamic json) {
    if (json is List) {
      // If the API returns a list directly
      return GalleryResponse(
        items: json.map((item) => GalleryItem.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      // If the API returns an object with an 'items' field
      return _$GalleryResponseFromJson(json);
    } else {
      // Handle unexpected format
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  // Make this method static
  static GalleryResponse convert(dynamic value) {
    return GalleryResponse.fromJson(value);
  }

  Map<String, dynamic> toJson() => _$GalleryResponseToJson(this);
}
