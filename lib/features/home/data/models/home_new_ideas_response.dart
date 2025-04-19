import 'package:json_annotation/json_annotation.dart';

part 'home_new_ideas_response.g.dart';

@JsonSerializable()
class HomeNewIdeasItem {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "image_url")
  final String imageUrl;
  final String brand;
  final String occasion;
  final String recipient;
  final String subCategory;
  final String textOnImage;
  final String textOnButton;

  HomeNewIdeasItem({
    required this.id,
    required this.imageUrl,
    required this.brand,
    required this.occasion,
    required this.recipient,
    required this.subCategory,
    required this.textOnImage,
    required this.textOnButton,
  });

  factory HomeNewIdeasItem.fromJson(Map<String, dynamic> json) =>
      _$HomeNewIdeasItemFromJson(json);

  Map<String, dynamic> toJson() => _$HomeNewIdeasItemToJson(this);
}

@JsonSerializable()
class HomeNewIdeasResponse {
  final List<HomeNewIdeasItem> items;

  HomeNewIdeasResponse({required this.items});

  factory HomeNewIdeasResponse.fromJson(dynamic json) {
    if (json is List) {
      return HomeNewIdeasResponse(
        items: json.map((item) => HomeNewIdeasItem.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      return _$HomeNewIdeasResponseFromJson(json);
    } else {
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  Map<String, dynamic> toJson() => _$HomeNewIdeasResponseToJson(this);
}
