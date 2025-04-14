import 'package:json_annotation/json_annotation.dart';

part 'my_occasions_response.g.dart';

@JsonSerializable()
class MyOccasionItem {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final DateTime date;
  @JsonKey(name: "__v")
  final int version;

  MyOccasionItem({
    required this.id,
    required this.name,
    required this.date,
    required this.version,
  });

  factory MyOccasionItem.fromJson(Map<String, dynamic> json) =>
      _$MyOccasionItemFromJson(json);

  Map<String, dynamic> toJson() => _$MyOccasionItemToJson(this);
}

@JsonSerializable()
class MyOccasionsResponse {
  final List<MyOccasionItem> items;

  MyOccasionsResponse({required this.items});

  // Custom fromJson that handles direct list response
  factory MyOccasionsResponse.fromJson(dynamic json) {
    if (json is List) {
      // If the API returns a list directly
      return MyOccasionsResponse(
        items: json.map((item) => MyOccasionItem.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic> && json.containsKey('items')) {
      // If the API returns an object with an 'items' field
      return _$MyOccasionsResponseFromJson(json);
    } else {
      // Handle unexpected format
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  // Static converter method
  static MyOccasionsResponse convert(dynamic value) {
    return MyOccasionsResponse.fromJson(value);
  }

  Map<String, dynamic> toJson() => _$MyOccasionsResponseToJson(this);
}