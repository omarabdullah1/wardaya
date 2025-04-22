import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';

import 'video_upload_state.dart';

class VideoUploadCubit extends Cubit<VideoUploadState> {
  final CartRepo _cartRepo;
  
  VideoUploadCubit(this._cartRepo) : super(const VideoUploadState.initial());
  
  Future<void> uploadVideo(Uint8List videoBytes, String fileName) async {
    emit(const VideoUploadState.loading());
    
    try {
      final response = await _cartRepo.uploadVideo(videoBytes, fileName);
      
      response.when(
        success: (data) {
          log('Successfully uploaded video: ${data.videoUrl}');
          emit(VideoUploadState.loaded(data.videoUrl));
        },
        failure: (error) {
          log('Error uploading video: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(VideoUploadState.error(error.message ?? 'Failed to upload video'));
        },
      );
    } catch (e, stackTrace) {
      log('Video upload unexpected error: $e', stackTrace: stackTrace);
      emit(VideoUploadState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}