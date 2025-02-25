import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/authentication/profile/data/repos/profile_repo.dart';
import 'package:wardaya/features/authentication/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());

  void getProfile() async {
    emit(const ProfileState.loading());
    final response = await _profileRepo.getProfile();
    response.when(success: (profileResponse) async {
      emit(ProfileState.success(profileResponse));
    }, failure: (error) {
      emit(ProfileState.error(error: error.message ?? ''));
    });
  }
}
