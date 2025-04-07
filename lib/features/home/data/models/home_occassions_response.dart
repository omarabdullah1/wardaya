import 'package:json_annotation/json_annotation.dart';

part 'home_occassions_response.g.dart';

@JsonSerializable()
class OccassionsItem {
  @JsonKey(name: "_id")
  final String id;
  final String? name; // Nullable
  @JsonKey(name: "image_url")
  final String imageUrl;

  OccassionsItem({
    required this.id,
    this.name,
    required this.imageUrl,
  });

  factory OccassionsItem.fromJson(Map<String, dynamic> json) =>
      _$OccassionsItemFromJson(json);

  Map<String, dynamic> toJson() => _$OccassionsItemToJson(this);
}

@JsonSerializable()
class OccassionsResponse {
  final List<OccassionsItem> items;

  OccassionsResponse({required this.items});

  // Custom fromJson that handles both List and Map responses
  factory OccassionsResponse.fromJson(dynamic json) {
    if (json is List) {
      // If the API returns a list directly
      return OccassionsResponse(
        items: json.map((item) => OccassionsItem.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      // If the API returns an object with an 'items' field
      return _$OccassionsResponseFromJson(json);
    } else {
      // Handle unexpected format
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  // Make this method static
  static OccassionsResponse convert(dynamic value) {
    return OccassionsResponse.fromJson(value);
  }

  Map<String, dynamic> toJson() => _$OccassionsResponseToJson(this);
}
