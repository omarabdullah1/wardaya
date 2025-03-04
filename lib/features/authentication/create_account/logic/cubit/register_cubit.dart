import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wardaya/features/authentication/create_account/data/models/create_account_request_body.dart';
import 'package:wardaya/features/authentication/create_account/data/repos/create_account_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateAccountRepo _createAccountRepo;

  RegisterCubit(this._createAccountRepo) : super(const RegisterState.initial());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<TooltipState> fullNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> phoneTooltipKey = GlobalKey<TooltipState>();

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  bool isPasswordVisible = false;

  String countryCode = '+966';
  String selectedBirthDate = '';

  void setCountryCode(String code) {
    countryCode = code;
    emit(RegisterState.setCountryCode(code));
  }

  void emitRegisterStates({
    required String fullName,
    required String password,
    required String phone,
    required String email,
  }) async {
    final names = splitFullName(fullName);
    final firstName = names['firstName']!;
    final lastName = names['lastName']!;

    emit(const RegisterState.loading());
    final response = await _createAccountRepo.createAccount(
      CreateAccountRequestBody(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        countryCode: countryCode,
        phoneNumber: phone,
        birthDate: selectedBirthDate,
        gender: 'Male',
      ),
    );
    response.when(success: (registerResponse) {
      emit(RegisterState.success(registerResponse));
    }, failure: (error) {
      log('message: ${error.error}');
      emit(RegisterState.error(error: error.error ?? ''));
    });
  }

  void setBirthDate(DateTime birthDate) {
    selectedBirthDate = '${birthDate.day}/${birthDate.month}/${birthDate.year}';
    emit(RegisterState.setBirthDate(selectedBirthDate));
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterState.togglePasswordVisibility(isPasswordVisible));
  }

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
