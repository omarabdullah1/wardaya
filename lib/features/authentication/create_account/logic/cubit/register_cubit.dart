import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/authentication/create_account/data/models/create_account_request_body.dart';
import 'package:wardaya/features/authentication/create_account/data/repos/create_account_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final CreateAccountRepo _createAccountRepo;

  RegisterCubit(this._createAccountRepo) : super(const RegisterState.initial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String countryCode = '+966';

  void setCountryCode(String code) {
    countryCode = code;
    emit(RegisterState.setCountryCode(code));
  }

  void emitRegisterStates() async {
    final String firstName;
    final String lastName;
    if (nameController.text.contains(' ')) {
      final names = nameController.text.split(' ');
      firstName = names[0];
      lastName = names[1];
    } else {
      firstName = nameController.text;
      lastName = '';
    }
    emit(const RegisterState.loading());
    final response = await _createAccountRepo.createAccount(
      CreateAccountRequestBody(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstName,
        lastName: lastName,
        countryCode: countryCode,
        birthDate: '1/1/1999',
        gender: 'Male',
      ),
    );
    response.when(success: (registerResponse) {
      emit(RegisterState.success(registerResponse));
    }, failure: (error) {
      emit(RegisterState.error(error: error.message ?? ''));
    });
  }
}
