import 'package:json_annotation/json_annotation.dart';

part 'create_occasion_response.g.dart';

@JsonSerializable()
class UserOccasion {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final DateTime date;
  @JsonKey(name: "__v")
  final int version;

  UserOccasion({
    required this.id,
    required this.name,
    required this.date,
    required this.version,
  });

  factory UserOccasion.fromJson(Map<String, dynamic> json) =>
      _$UserOccasionFromJson(json);

  Map<String, dynamic> toJson() => _$UserOccasionToJson(this);
}

@JsonSerializable()
class CreateOccasionResponse {
  final String message;
  final UserOccasion userOccasion;

  CreateOccasionResponse({
    required this.message,
    required this.userOccasion,
  });

  factory CreateOccasionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOccasionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOccasionResponseToJson(this);
}
