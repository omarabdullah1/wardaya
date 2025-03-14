import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/authentication/login/data/models/login_response.dart';
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
      await userDataToString(loginResponse);
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.message ?? ''));
    });
  }

  Future<void> userDataToString(LoginResponse response) async {
    try {
      final String serializedData = jsonEncode(response.toJson());
      await saveUserData(serializedData);
    } catch (e) {
      log('Error serializing login response: $e');
      throw Exception('Failed to serialize login data');
    }
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  Future<void> saveUserData(String response) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userData, response);
  }

  bool isSigningIn = false;

  Future<void> handleSignInWithGoogle(BuildContext context) async {
    if (isSigningIn) {
      return; // Prevent concurrent calls
    }
    isSigningIn = true;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? accessToken = googleAuth.accessToken;
        final String? idToken = googleAuth.idToken;
        // await FlutterClipboard.copy(idToken ?? '').then(
        //   (_) {
        //     return snackbarShow(
        //       context.mounted ? context : context,
        //       'Copied to clipboard',
        //     );
        // },
        // );
        log('User Name: ${googleUser.displayName}');
        log('Access Token: $accessToken');
        log('Id Token: $idToken');
        // TODO: Send the access token to your backend server
      } else {
        log('Sign-in cancelled by user.');
      }
    } catch (error) {
      log('Error signing in: $error');
      snackbarShow(
        context.mounted ? context : context,
        'Error signing in: $error',
      );
    } finally {
      isSigningIn = false;
    }
  }

  Future<void> handleSignInWithApple() async {
    if (isSigningIn) {
      return; // Prevent concurrent calls
    }

    isSigningIn = true;

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
      isSigningIn = false;
    }
  }

  dynamic snackbarShow(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorsManager.grey,
        duration: const Duration(seconds: 5),
        content: Text(
          message,
          style: TextStylesInter.font15WhiteRegular,
        ),
      ),
    );
  }
}
