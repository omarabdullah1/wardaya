import 'dart:developer';

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
    response.when(success: (profileResponse) {
      // First check if we got a proper response with data
      if (profileResponse.firstName != null) {
        emit(ProfileState.success(profileResponse));
        firstNameController.text = profileResponse.firstName!;
        lastNameController.text = profileResponse.lastName!;
        emailController.text = profileResponse.email!;
        passwordController.text = profileResponse.password!;
        phoneController.text = profileResponse.phoneNumber.toString();
        dateOfBirthController.text = profileResponse.birthDate.toString();
      } else {
        // Handle the case where we got a success but with null data
        handleUnauthorized(context);
      }
    }, failure: (error) async {
      if (error.message == 'Unauthorized') {
        handleUnauthorized(context);
      } else {
        emit(ProfileState.error(error: error.message ?? ''));
      }
    });
  }

  void handleUnauthorized(BuildContext context) async {
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
      SharedPrefHelper.removeSecuredString(SharedPrefKeys.userAreaId);
      SharedPrefHelper.removeSecuredString(SharedPrefKeys.userID);
      isLoggedInUser = false;
      context.read<LayoutCubit>().close();
      context.pushNamedAndRemoveUntil(
        Routes.homeLayout,
        predicate: (route) => false,
      );
    }
    emit(const ProfileState.error(error: 'Unauthorized access'));
  }

  /// Delete the user account using the ID stored in SharedPreferences
  /// Displays appropriate messages according to the response
  void deleteAccount(BuildContext context) async {
    // Show loading state
    emit(const ProfileState.loading());

    // Get user ID from shared preferences
    final userId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userID);

    if (userId == null || userId.isEmpty) {
      emit(const ProfileState.error(error: 'User ID not found'));
      if (context.mounted) {
        _showErrorSnackBar(
            context, 'Unable to delete account: User ID not found');
      }
      return;
    }

    log('Deleting account for user ID: $userId');

    // Call the delete account API
    final response = await _profileRepo.deleteAccount(userId);

    response.when(success: (deleteResponse) {
      if (deleteResponse.deleteResult.acknowledged &&
          deleteResponse.deleteResult.deletedCount > 0) {
        // Success: account was deleted
        _showSuccessSnackBar(context, 'Account successfully deleted');

        // Clear user data from shared preferences
        _clearUserData();

        // Navigate to login screen
        context.pushNamedAndRemoveUntil(
          Routes.homeLayout,
          predicate: (route) => false,
        );
      } else {
        // API returned success but no account was deleted
        emit(const ProfileState.error(error: 'Account could not be deleted'));
        _showErrorSnackBar(
            context, 'Account could not be deleted. Please try again later.');
      }
    }, failure: (error) {
      // API returned an error
      _showErrorSnackBar(context, error.message ?? 'Failed to delete account');
      emit(ProfileState.error(
          error: error.message ?? 'Failed to delete account'));
    });
  }

  // Update user profile with new information
  void updateUser(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
  }) async {
    // Set state to updating
    emit(const ProfileState.updating());

    log('Updating user profile: firstName=$firstName, lastName=$lastName, phoneNumber=$phoneNumber, countryCode=$countryCode');

    // Call repository to update user
    final response = await _profileRepo.updateUser(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );

    // Handle response
    response.when(success: (updateResponse) {
      // Update was successful
      emit(ProfileState.updateSuccess(updateResponse));

      // Update controllers with new data
      firstNameController.text = updateResponse.user.firstName ?? '';
      lastNameController.text = updateResponse.user.lastName ?? '';
      phoneController.text = updateResponse.user.phoneNumber ?? '';

      // Show success message
      _showSuccessSnackBar(context, updateResponse.message);

      // Update profile data in app state
      getProfile(context);
    }, failure: (error) {
      // Handle error
      emit(ProfileState.updateError(
          error: error.message ?? 'Failed to update profile'));
      _showErrorSnackBar(context, error.message ?? 'Failed to update profile');
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStylesInter.font12WhiteBold,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStylesInter.font12WhiteBold,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearUserData() {
    SharedPrefHelper.removeSecuredString(SharedPrefKeys.userToken);
    SharedPrefHelper.removeSecuredString(SharedPrefKeys.userData);
    SharedPrefHelper.removeSecuredString(SharedPrefKeys.userID);
    SharedPrefHelper.removeSecuredString(SharedPrefKeys.userAreaId);
  }

  // Utility method to split a full name into firstName and lastName
  // This uses the same logic as in RegisterCubit
  Map<String, String> splitFullName(String fullName) {
    const String specialEmptyChar = '؜'; // Special empty character

    // Remove any leading/trailing spaces and multiple spaces between words
    final cleanedFullName = fullName.trim().replaceAll(RegExp(r'\s+'), ' ');

    // Split the name by single space
    final nameParts = cleanedFullName.split(' ');

    // Get firstName and handle lastName
    final firstName = nameParts[0];
    final lastName = nameParts.length > 1 && nameParts[1].isNotEmpty
        ? nameParts.sublist(1).join(' ')
        : specialEmptyChar;

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
