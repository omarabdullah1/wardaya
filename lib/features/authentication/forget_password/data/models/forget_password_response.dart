import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  final String? message;

  ForgetPasswordResponse({
    this.message,
  });

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
}
