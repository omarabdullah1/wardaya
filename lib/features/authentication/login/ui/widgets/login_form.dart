import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../logic/cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return // Email TextField using localized label
        Form(
      key: cubit.formKey,
      child: Column(
        children: [
          TextField(
            controller: cubit.emailController,
            decoration: InputDecoration(
              labelText: context.el.emailLabel,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsManager.grey,
                  width: 1.5,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsManager.grey,
                  width: 1.5,
                ),
              ),
              labelStyle: TextStylesInter.font15GreyRegular,
            ),
          ),
          verticalSpace(13),
          // Password TextField using localized label
          TextField(
            controller: cubit.passwordController,
            onSubmitted: (value) => validateThenDoLogin(context),
            decoration: InputDecoration(
              labelText: context.el.passwordLabel,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsManager.grey,
                  width: 1.5,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsManager.grey,
                  width: 1.5,
                ),
              ),
              labelStyle: TextStylesInter.font15GreyRegular,
            ),
            obscureText: true, // Hide password
          ),
          verticalSpace(18),
          // "Sign in with" text from localization
          AppTextButton(
            buttonText: context.el.signInButton,
            textStyle: TextStylesInter.font15WhiteRegular,
            borderRadius: 5,
            buttonHeight: 45.h,
            onPressed: () => validateThenDoLogin(context),
          ),
          verticalSpace(13),
          // Row for "Forget Password?" and "Create Account"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.forgetPasswordScreen);
                },
                child: Text(
                  context.el.forgetPassword,
                  style: TextStylesInter.font13BlackRegular,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.createAccountScreen);
                },
                child: Text(
                  context.el.createAccount,
                  style: TextStylesInter.font13BlackRegular,
                ),
              ),
            ],
          ),
          verticalSpace(18),
          // Row for divider with localized "OR"
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  context.el.dividerText,
                  style: TextStylesInter.font14BlackRegular,
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          verticalSpace(8),
        ],
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.emitLoginStates();
    }
  }
}
