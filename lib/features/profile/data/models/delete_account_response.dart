import 'package:json_annotation/json_annotation.dart';

part 'delete_account_response.g.dart';

@JsonSerializable()
class DeleteResult {
  final bool acknowledged;
  final int deletedCount;

  DeleteResult({required this.acknowledged, required this.deletedCount});

  factory DeleteResult.fromJson(Map<String, dynamic> json) =>
      _$DeleteResultFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteResultToJson(this);
}

@JsonSerializable()
class DeleteAccountResponse {
  final String message;
  final DeleteResult deleteResult;

  DeleteAccountResponse({required this.message, required this.deleteResult});

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAccountResponseToJson(this);
}
