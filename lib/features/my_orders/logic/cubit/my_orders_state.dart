import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/profile/data/models/profile_response.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState<T> with _$ProfileState<T> {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.loading() = Loading;
  const factory ProfileState.success(ProfileResponse data) = ProfileSuccess<T>;
  const factory ProfileState.error({required String error}) = Error;
}
