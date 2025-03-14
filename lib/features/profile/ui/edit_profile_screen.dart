import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_back_app_bar.dart';
import '../../../core/widgets/app_text_button.dart';
import '../logic/cubit/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderFieldState> emailFieldKey =
      GlobalKey<FormBuilderFieldState>();
  final GlobalKey<TooltipState> fullNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  initState() {
    super.initState();
    fullNameController.text = getFullName(context);
    emailController.text = getEmail(context);
    passwordController.text = getPassword(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackAppBar(
        title: context.el.editProfileTitle,
        onBack: () => context.pop(),
      ),
      bottomNavigationBar: bottomCreateAccount(
        context: context,
        onPressed: () {
          setState(() {
            if (formKey.currentState!.saveAndValidate()) {
              if (true) {
                // Either invalidate using Form Key
                formKey.currentState?.fields['email']
                    ?.invalidate('Email already taken.');
                // OR invalidate using Field Key
                // _emailFieldKey.currentState?.invalidate('Email already taken.');
              }
            }
            debugPrint(formKey.currentState?.value.toString());
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'full_name',
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: context.el.firstNameLabel,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon:
                      formKey.currentState?.fields['full_name']?.hasError ??
                              false
                          ? toolTipBuilder(fullNameTooltipKey, 'Required')
                          : null,
                  labelStyle: TextStylesInter.font15GreyRegular,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                key: emailFieldKey,
                name: 'email',
                controller: emailController,
                decoration: InputDecoration(
                  labelText: context.el.emailAddressLabel,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon:
                      formKey.currentState?.fields['email']?.hasError ?? false
                          ? toolTipBuilder(fullNameTooltipKey, 'Required')
                          : null,
                  labelStyle: TextStylesInter.font15GreyRegular,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'password',
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: context.el.passwordLabel,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon:
                      formKey.currentState?.fields['Password']?.hasError ??
                              false
                          ? toolTipBuilder(fullNameTooltipKey, 'Required')
                          : null,
                  labelStyle: TextStylesInter.font15GreyRegular,
                ),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toolTipBuilder(
    GlobalKey<TooltipState> tooltipKey,
    String message,
  ) {
    return Tooltip(
      key: tooltipKey,
      message: message,
      decoration: const BoxDecoration(
        color: ColorsManager.black,
      ),
      verticalOffset: 22.5.h,
      textStyle: TextStylesInter.font15WhiteRegular,
      padding: const EdgeInsets.all(12),
      preferBelow: true, // Tooltip appears below the icon
      child: GestureDetector(
        onTap: () {
          tooltipKey.currentState?.ensureTooltipVisible();
        },
        child: const Icon(Icons.error, color: ColorsManager.red),
      ),
    );
  }

  Widget bottomCreateAccount(
      {required BuildContext context, required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: ColorsManager.white,
        child: AppTextButton(
          buttonText: context.el.saveChangesButton,
          textStyle: TextStylesInter.font15WhiteRegular,
          borderRadius: 5,
          buttonHeight: 45.h,
          onPressed: () => onPressed(),
        ),
      ),
    );
  }

  String getFullName(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String fullName = '';
    cubit.state.whenOrNull(
      success: (profileResponse) {
        fullName =
            '${profileResponse.firstName ?? ''} ${profileResponse.lastName ?? ''}';
      },
    );
    log(fullName);
    return fullName;
  }

  String getEmail(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String email = '';
    cubit.state.whenOrNull(
      success: (profileResponse) {
        email = profileResponse.email ?? '';
      },
    );
    log(email);
    return email;
  }

  String getPassword(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String password = '';
    cubit.state.whenOrNull(
      success: (profileResponse) {
        password = profileResponse.password ?? '';
      },
    );
    log(password);
    return password;
  }
}
