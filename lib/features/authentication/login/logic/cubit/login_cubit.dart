import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/networking/dio_factory.dart';
import '../../data/models/login_request_body.dart';
import '../../data/repos/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      await saveUserToken(loginResponse.token ?? '');
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.message ?? ''));
    });
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  bool _isSigningIn = false;

  Future<void> handleSignInWithGoogle() async {
    if (_isSigningIn) {
      return; // Prevent concurrent calls
    }
    _isSigningIn = true;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? accessToken = googleAuth.accessToken;

        log('User Name: ${googleUser.displayName}');
        log('Access Token: $accessToken');
        // TODO: Send the access token to your backend server
      } else {
        log('Sign-in cancelled by user.');
      }
    } catch (error) {
      log('Error signing in: $error');
    } finally {
      _isSigningIn = false;
    }
  }

  Future<void> handleSignInWithApple() async {
    if (_isSigningIn) {
      return; // Prevent concurrent calls
    }

    _isSigningIn = true;

    try {
      final AuthorizationCredentialAppleID result =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      log('Result: $result');
      // Handle the sign-in result (e.g., send the `result.identityToken` to your backend)
    } catch (e) {
      log('Error signing in with Apple: $e');
      // Handle errors
    } finally {
      _isSigningIn = false;
    }
  }
}
