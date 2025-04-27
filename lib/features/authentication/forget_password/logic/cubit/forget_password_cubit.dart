import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/authentication/forget_password/data/models/forget_password_response.dart';
import 'package:wardaya/features/authentication/forget_password/data/repos/forget_password_repo.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _forgetPasswordRepo;

  ForgetPasswordCubit(this._forgetPasswordRepo)
      : super(const ForgetPasswordState.initial());

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void requestPasswordReset() async {
    if (emailController.text.isEmpty) {
      emit(const ForgetPasswordState.error(error: 'Email is required'));
      return;
    }

    emit(const ForgetPasswordState.loading());

    final response =
        await _forgetPasswordRepo.forgetPassword(emailController.text);

    response.when(success: (ForgetPasswordResponse data) {
      log('Password reset request successful: ${data.message}');
      emit(ForgetPasswordState.success(data));
    }, failure: (error) {
      log('Password reset request failed: ${error.message}');
      emit(ForgetPasswordState.error(
          error: error.message ?? 'Failed to send password reset link'));
    });
  }

  void snackbarShow(
    BuildContext context,
    String message, {
    Color color = ColorsManager.darkGray,
  }) {
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: color,
    );
  }
}
