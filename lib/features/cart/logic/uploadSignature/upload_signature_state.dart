import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/cart/data/models/upload_signature_response.dart';

part 'upload_signature_state.freezed.dart';

@freezed
class UploadSignatureState with _$UploadSignatureState {
  const factory UploadSignatureState.initial() = _Initial;
  const factory UploadSignatureState.loading() = Loading;
  const factory UploadSignatureState.loaded(UploadSignatureResponse response) =
      Loaded;
  const factory UploadSignatureState.error(String message) = Error;
}
