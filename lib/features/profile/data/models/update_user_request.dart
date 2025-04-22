import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  @JsonKey(name: "country_code")
  final String? countryCode;

  UpdateUserRequest({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.countryCode,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
