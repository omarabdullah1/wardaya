import 'package:json_annotation/json_annotation.dart';

part 'upload_signature_response.g.dart';

@JsonSerializable()
class UploadSignatureResponse {
  @JsonKey(name: 'image_url')
  final String imageUrl;

  UploadSignatureResponse({
    required this.imageUrl,
  });

  factory UploadSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadSignatureResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UploadSignatureResponseToJson(this);
}
