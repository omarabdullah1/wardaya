import 'package:json_annotation/json_annotation.dart';
import 'profile_response.dart';

part 'update_user_response.g.dart';

@JsonSerializable()
class UpdateUserResponse {
  final String message;
  final ProfileResponse user;

  UpdateUserResponse({
    required this.message,
    required this.user,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateUserResponseToJson(this);
}