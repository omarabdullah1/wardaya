import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/widgets/app_text_button.dart';
import 'package:wardaya/features/authentication/create_account/logic/cubit/register_cubit.dart';
import 'package:wardaya/features/authentication/create_account/ui/widgets/create_account_form.dart';

import '../../../../core/theming/colors.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          // Using localized string for the app bar title
          context.el.createAccountTitle,
          style: GoogleFonts.inter(
            fontSize: 17.0.sp,
            fontWeight: FontWeight.w700,
            color: ColorsManager.mainRose,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: ColorsManager.white,
          child: AppTextButton(
            buttonText: context.el.signInButton,
            textStyle: TextStylesInter.font15WhiteRegular,
            borderRadius: 5,
            buttonHeight: 45.h,
            onPressed: () => validateThenDoRegister(context),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateAccountForm(),
      ),
    );
  }

  void validateThenDoRegister(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.emitRegisterStates();
    }
  }
}
