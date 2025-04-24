import 'package:json_annotation/json_annotation.dart';

part 'video_upload_response.g.dart';

@JsonSerializable()
class VideoUploadResponse {
  final String videoUrl;

  VideoUploadResponse({
    required this.videoUrl,
  });

  factory VideoUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoUploadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VideoUploadResponseToJson(this);
}
