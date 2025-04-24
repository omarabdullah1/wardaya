class UploadVideoResponse {
  final String videoUrl;

  UploadVideoResponse({required this.videoUrl});

  factory UploadVideoResponse.fromJson(Map<String, dynamic> json) {
    return UploadVideoResponse(
      videoUrl: json['video_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_url': videoUrl,
    };
  }
}