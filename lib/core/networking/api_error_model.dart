import 'package:json_annotation/json_annotation.dart';
import 'package:wardaya/core/helpers/extensions.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final String? error;

  ApiErrorModel({
    this.message,
    this.error,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Returns a String containing all the error messages
  String getAllErrorMessages() {
    if (error.isNullOrEmpty()) {
      return message ?? "Unknown Error occurred";
    }

    if (!error.isNullOrEmpty()) {
      final errorMessage = error;

      return errorMessage ?? "Unknown Error occurred";
    } else if (error.isNullOrEmpty() && message.isNullOrEmpty()) {
      return error ?? "Unknown Error occurred";
    }

    return message ?? "Unknown Error occurred";
  }
}
