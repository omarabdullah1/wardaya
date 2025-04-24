import 'package:json_annotation/json_annotation.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';

part 'create_occasion_response.g.dart';

@JsonSerializable()
class CreateOccasionResponse {
  final String message;
  @JsonKey(name: "userOccasion")
  final MyOccasionItem userOccasion;

  CreateOccasionResponse({
    required this.message,
    required this.userOccasion,
  });

  factory CreateOccasionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOccasionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOccasionResponseToJson(this);
}

@JsonSerializable()
class CreateOccasionRequest {
  final String name;
  final String date; // Format: "YYYY-MM-DD"

  CreateOccasionRequest({
    required this.name,
    required this.date,
  });

  factory CreateOccasionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOccasionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOccasionRequestToJson(this);
}
