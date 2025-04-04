import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_gallery_response.dart';
part 'gallery_state.freezed.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState.initial() = _Initial;
  const factory GalleryState.loading() = Loading;
  const factory GalleryState.success(GalleryResponse response) = Success;
  const factory GalleryState.error(String message) = Error;
}
