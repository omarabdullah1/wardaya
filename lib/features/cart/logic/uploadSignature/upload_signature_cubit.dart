import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';

import 'upload_signature_state.dart';

class UploadSignatureCubit extends Cubit<UploadSignatureState> {
  final CartRepo _cartRepo;
  
  UploadSignatureCubit(this._cartRepo) : super(const UploadSignatureState.initial());

  Future<void> uploadSignature(Uint8List imageBytes, {String fileName = 'signature.png'}) async {
    emit(const UploadSignatureState.loading());
    try {
      final response = await _cartRepo.uploadSignature(imageBytes, fileName);
      response.when(
        success: (data) {
          log('Successfully uploaded signature image');
          emit(UploadSignatureState.loaded(data));
        },
        failure: (error) {
          log('Error uploading signature image: ${error.message}');
          emit(UploadSignatureState.error(
              error.message ?? 'Failed to upload signature image'));
        },
      );
    } catch (e, stackTrace) {
      log('Signature upload unexpected error: $e', stackTrace: stackTrace);
      emit(UploadSignatureState.error(
          'An unexpected error occurred while uploading signature: ${e.toString()}'));
    }
  }
}