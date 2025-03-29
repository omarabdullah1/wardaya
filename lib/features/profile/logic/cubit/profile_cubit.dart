import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wardaya/core/helpers/constants.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/profile/data/repos/profile_repo.dart';
import 'package:wardaya/features/profile/logic/cubit/profile_state.dart';

import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/routing/router_imports.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(const ProfileState.initial());

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<TooltipState> firstNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> lastNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> phoneTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> dateOfBirthTooltipKey =
      GlobalKey<TooltipState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void getProfile(BuildContext context) async {
    emit(const ProfileState.loading());
    final response = await _profileRepo.getProfile();
    response.when(success: (profileResponse) async {
      emit(ProfileState.success(profileResponse));
      firstNameController.text = profileResponse.firstName!;
      lastNameController.text = profileResponse.lastName!;
      emailController.text = profileResponse.email!;
      passwordController.text = profileResponse.password!;
      phoneController.text = profileResponse.phoneNumber.toString();
      dateOfBirthController.text = profileResponse.birthDate.toString();
    }, failure: (error) async {
      if (error.message == 'Unauthorized') {
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Session has been expired',
                style: TextStylesInter.font12WhiteBold,
              ),
              backgroundColor: Colors.red,
            ),
          );
          SharedPrefHelper.removeSecuredString(SharedPrefKeys.userToken);
          SharedPrefHelper.removeSecuredString(SharedPrefKeys.userData);
          context.pushNamedAndRemoveUntil(
            Routes.loginScreen,
            predicate: (route) => false,
          );
        }
      }
      emit(ProfileState.error(error: error.message ?? ''));
    });
  }
}
