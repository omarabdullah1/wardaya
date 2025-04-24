import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_upload_state.freezed.dart';

@freezed
class VideoUploadState with _$VideoUploadState {
  const factory VideoUploadState.initial() = _Initial;
  const factory VideoUploadState.loading() = _Loading;
  const factory VideoUploadState.loaded(String videoUrl) = _Loaded;
  const factory VideoUploadState.error(String message) = _Error;
}