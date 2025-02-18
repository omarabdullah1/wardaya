import 'package:flutter/material.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/authentication/login/ui/widgets/sign_in_with_google_apple_row.dart';
import 'widgets/login_bloc_listener.dart';
import 'widgets/login_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Handles keyboard overflow
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // App Title from localization
              Text(
                context.el.appTitle,
                style: TextStylesInter.font17MainRoseBold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(18),
              const LoginForm(),
              const LoginBlocListener(),
              Text(
                context.el.signInWith,
                style: TextStylesInter.font14BlackRegular,
                textAlign: TextAlign.center,
              ),
              verticalSpace(18),
              const SignInWithGoogleAppleRow(),
            ],
          ),
        ),
      ),
    );
  }
}
