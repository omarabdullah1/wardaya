import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_back_app_bar.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../logic/cubit/profile_cubit.dart';
import '../../../../core/helpers/form_fields_keys.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBackAppBar(
        title: context.el.editProfileTitle,
        onBack: () => context.pop(),
      ),
      bottomNavigationBar: bottomCreateAccount(
        context: context,
        onPressed: () {
          setState(() {
            if (cubit.formKey.currentState!.saveAndValidate()) {
              if (true) {
                // Either invalidate using Form Key
                cubit.formKey.currentState?.fields[FormFieldsKeys.email]
                    ?.invalidate('Email already taken.');
                // OR invalidate using Field Key
                // _emailFieldKey.currentState?.invalidate('Email already taken.');
              }
            }
            debugPrint(cubit.formKey.currentState?.value.toString());
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  Assets.of(context).svgs.user_svg,
                  height: 80.h,
                  width: 80.h,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 25.h,
                    width: 25.h,
                    decoration: const BoxDecoration(
                      color: ColorsManager.mainRose,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: ColorsManager.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(35.0),
            FormBuilder(
              key: cubit.formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: FormFieldsKeys.firstName,
                    controller: cubit.firstNameController,
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
                      suffixIcon: cubit
                                  .formKey
                                  .currentState
                                  ?.fields[FormFieldsKeys.firstName]
                                  ?.hasError ??
                              false
                          ? toolTipBuilder(
                              cubit.firstNameTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  verticalSpace(10.0),
                  FormBuilderTextField(
                    name: FormFieldsKeys.lastName,
                    controller: cubit.lastNameController,
                    decoration: InputDecoration(
                      labelText: context.el.lastNameLabel,
                      border: borderStyle(),
                      enabledBorder: borderStyle(),
                      suffixIcon: cubit.formKey.currentState
                                  ?.fields[FormFieldsKeys.lastName]?.hasError ??
                              false
                          ? toolTipBuilder(cubit.lastNameTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  verticalSpace(10.0),
                  FormBuilderTextField(
                    key: cubit.emailFieldKey,
                    name: FormFieldsKeys.email,
                    controller: cubit.emailController,
                    decoration: InputDecoration(
                      labelText: context.el.emailAddressLabel,
                      border: borderStyle(),
                      enabledBorder: borderStyle(),
                      suffixIcon: cubit.formKey.currentState
                                  ?.fields[FormFieldsKeys.email]?.hasError ??
                              false
                          ? toolTipBuilder(cubit.emailTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  verticalSpace(10.0),
                  FormBuilderTextField(
                    name: FormFieldsKeys.password,
                    controller: cubit.passwordController,
                    decoration: InputDecoration(
                      labelText: context.el.passwordLabel,
                      border: borderStyle(),
                      enabledBorder: borderStyle(),
                      suffixIcon: cubit.formKey.currentState
                                  ?.fields[FormFieldsKeys.password]?.hasError ??
                              false
                          ? toolTipBuilder(cubit.passwordTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                  ),
                  verticalSpace(10.0),
                  FormBuilderTextField(
                    name: FormFieldsKeys.phone,
                    controller: cubit.phoneController,
                    decoration: InputDecoration(
                      labelText: context.el.phoneLabel,
                      border: borderStyle(),
                      enabledBorder: borderStyle(),
                      suffixIcon: cubit.formKey.currentState
                                  ?.fields[FormFieldsKeys.phone]?.hasError ??
                              false
                          ? toolTipBuilder(cubit.phoneTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  verticalSpace(10.0),
                  FormBuilderTextField(
                    name: FormFieldsKeys.dateOfBirth,
                    controller: cubit.dateOfBirthController,
                    decoration: InputDecoration(
                      labelText: context.el.birthdayLabel,
                      border: borderStyle(),
                      enabledBorder: borderStyle(),
                      suffixIcon: cubit
                                  .formKey
                                  .currentState
                                  ?.fields[FormFieldsKeys.dateOfBirth]
                                  ?.hasError ??
                              false
                          ? toolTipBuilder(
                              cubit.dateOfBirthTooltipKey, 'Required')
                          : null,
                      labelStyle: TextStylesInter.font15GreyRegular,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    keyboardType: TextInputType.datetime,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorsManager.grey,
        width: 1.0,
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
        child: const Icon(Icons.error, color: Colors.red),
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
}
