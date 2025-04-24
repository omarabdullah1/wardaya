import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/authentication/login/data/models/login_response.dart';
import 'package:wardaya/features/authentication/models/google_login_request.dart';

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
      // Check if the response contains a valid token
      if (loginResponse.token == null || loginResponse.token!.isEmpty) {
        // If no token, treat as an error even if API returned 200
        emit(LoginState.error(error: loginResponse.message ?? 'Login failed'));
        return;
      }
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.userAreaId,
          loginResponse.user?.selectedDeliveryArea ?? '');
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.userName,
          '${loginResponse.user!.firstName ?? ''} ${loginResponse.user!.lastName ?? ''}');

      await saveUserToken(loginResponse.token ?? '');
      await userDataToString(loginResponse);
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      log('Login error: ${error.message}');
      emit(LoginState.error(error: error.message ?? 'Login failed'));
    });
  }

  Future<void> userDataToString(LoginResponse response) async {
    try {
      await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.userID, response.user!.id!);
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
    emit(const LoginState.loading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String? idToken = googleAuth.idToken;

        if (idToken != null && idToken.isNotEmpty) {
          log('Google ID Token: $idToken');

          // Send the ID token to your backend
          final googleLoginRequest = GoogleLoginRequest(idToken: idToken);
          final response = await _loginRepo.loginWithGoogle(googleLoginRequest);

          response.when(success: (loginResponse) async {
            // Check if the response contains a valid token
            if (loginResponse.token == null || loginResponse.token!.isEmpty) {
              emit(LoginState.error(
                  error: loginResponse.message ?? 'Google login failed'));
              return;
            }

            // Save user area ID and name
            await SharedPrefHelper.setSecuredString(SharedPrefKeys.userAreaId,
                loginResponse.user?.selectedDeliveryArea ?? '');
            await SharedPrefHelper.setSecuredString(SharedPrefKeys.userName,
                '${loginResponse.user!.firstName ?? ''} ${loginResponse.user!.lastName ?? ''}');

            // Save token and user data
            await saveUserToken(loginResponse.token ?? '');
            await userDataToString(loginResponse);
            emit(LoginState.success(loginResponse));

            snackbarShow(
              context.mounted ? context : context,
              'Successfully signed in with Google',
              color: ColorsManager.mintGreen,
            );
          }, failure: (error) {
            log('Google login error: ${error.message}');
            emit(LoginState.error(
                error: error.message ?? 'Google login failed'));
            snackbarShow(
              context.mounted ? context : context,
              error.message ?? 'Failed to sign in with Google',
              color: ColorsManager.red,
            );
          });
        } else {
          emit(const LoginState.error(
              error: 'Failed to get ID token from Google'));
          snackbarShow(
            context.mounted ? context : context,
            'Failed to get authentication token from Google',
            color: ColorsManager.red,
          );
        }
      } else {
        emit(const LoginState.initial());
        log('Sign-in cancelled by user.');
      }
    } catch (error) {
      emit(LoginState.error(error: error.toString()));
      log('Error signing in with Google: $error');
      snackbarShow(
        context.mounted ? context : context,
        'Error signing in with Google: $error',
        color: ColorsManager.red,
      );
    } finally {
      isSigningIn = false;
    }
  }

  Future<void> handleSignInWithApple(BuildContext context) async {
    try {
      // Apple sign-in implementation
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      log('Apple User: ${credential.email}');
      log('Apple ID Token: ${credential.identityToken}');

      // TODO: Send the token to your backend server
    } catch (error) {
      log('Error signing in with Apple: $error');
      snackbarShow(
        context.mounted ? context : context,
        'Error signing in with Apple: $error',
        color: ColorsManager.red,
      );
    }
  }

  void snackbarShow(BuildContext context, String message,
      {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStylesInter.font12WhiteBold,
        ),
        backgroundColor: color,
      ),
    );
  }
}
