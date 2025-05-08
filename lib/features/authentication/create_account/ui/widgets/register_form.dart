import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart' as ccp;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:localization/localization.dart';

import '../../../../../core/helpers/form_fields_keys.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/styled_toast.dart';
import '../../logic/cubit/register_cubit.dart';
import '../../logic/cubit/register_state.dart';
import 'create_account_birthday_picker.dart';
import 'register_bloc_listener.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return FormBuilder(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RegisterBlocListener(),

            // Full Name Field with required indicator above
            _buildFieldLabel(context.el.fullNameLabel, isRequired: true),
            FormBuilderTextField(
              name: FormFieldsKeys.fullName,
              decoration: InputDecoration(
                labelText: context.el.fullNameLabel,
                labelStyle: TextStylesInter.font15GreyRegular,
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
                suffixIcon: FormBuilderField(
                  name: FormFieldsKeys.fullNameErrorListner,
                  builder: (FormFieldState<dynamic> field) {
                    return Visibility(
                      visible: cubit.formKey.currentState
                              ?.fields[FormFieldsKeys.fullName]?.hasError ??
                          false,
                      child: toolTipBuilder(
                          cubit.fullNameTooltipKey, context.el.fieldRequired),
                    );
                  },
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: ''),
              ]),
            ),
            const VerticalSpace(height: 10.0),

            // Email Field with required indicator above
            _buildFieldLabel(context.el.emailAddressLabel, isRequired: true),
            FormBuilderTextField(
              key: cubit.emailFieldKey,
              name: FormFieldsKeys.email,
              decoration: InputDecoration(
                labelText: context.el.emailAddressLabel,
                labelStyle: TextStylesInter.font15GreyRegular,
                border: borderStyle(),
                enabledBorder: borderStyle(),
                suffixIcon: FormBuilderField(
                  name: FormFieldsKeys.emailErrorListner,
                  builder: (FormFieldState<dynamic> field) {
                    return Visibility(
                      visible: cubit.formKey.currentState
                              ?.fields[FormFieldsKeys.email]?.hasError ??
                          false,
                      child: toolTipBuilder(
                          cubit.emailTooltipKey, context.el.fieldRequired),
                    );
                  },
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: ''),
                FormBuilderValidators.email(errorText: ''),
              ]),
            ),
            const VerticalSpace(height: 10.0),

            // Password Field with required indicator above
            _buildFieldLabel(context.el.passwordLabel, isRequired: true),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return FormBuilderTextField(
                  name: FormFieldsKeys.password,
                  decoration: InputDecoration(
                    labelText: context.el.passwordLabel,
                    labelStyle: TextStylesInter.font15GreyRegular,
                    border: borderStyle(),
                    enabledBorder: borderStyle(),
                    suffixIcon: FormBuilderField(
                      name: FormFieldsKeys.passwordErrorListner,
                      builder: (FormFieldState<dynamic> field) {
                        return Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Visibility(
                              visible: cubit
                                      .formKey
                                      .currentState
                                      ?.fields[FormFieldsKeys.password]
                                      ?.hasError ??
                                  false,
                              child: toolTipBuilder(cubit.passwordTooltipKey,
                                  context.el.fieldRequired),
                            ),
                            IconButton(
                              icon: Icon(
                                cubit.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorsManager.darkGray,
                              ),
                              onPressed: () {
                                cubit.togglePasswordVisibility();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  obscureText: !cubit.isPasswordVisible,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: ''),
                    FormBuilderValidators.minLength(6, errorText: ''),
                  ]),
                );
              },
            ),
            const VerticalSpace(height: 10.0),

            // Phone Field (optional)
            _buildFieldLabel(context.el.phoneLabel, isRequired: false),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: ColorsManager.grey,
                        width: 1.0,
                      ),
                    ),
                    child: ccp.CountryCodePicker(
                      onChanged: (ccp.CountryCode countryCode) {
                        cubit.setCountryCode(countryCode.dialCode.toString());
                        log(cubit.countryCode.toString());
                      },
                      headerText: context.el.selectCountryLabel,
                      initialSelection: 'SA',
                      favorite: const ['SA', 'EG', 'AE'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: TextStylesInter.font15DarkGreyRegular,
                      headerTextStyle:
                          TextStylesEBGaramond.font25MainRoseRegular,
                      closeIcon: const Icon(
                        Icons.close,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // Phone TextField using localized label
                  child: FormBuilderTextField(
                    name: 'phone',
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: context.el.phoneLabel,
                      labelStyle: TextStylesInter.font15GreyRegular,
                      suffixIcon: FormBuilderField(
                        name: FormFieldsKeys.phoneErrorListner,
                        builder: (FormFieldState<dynamic> field) {
                          return Visibility(
                            visible: cubit.formKey.currentState?.fields['phone']
                                    ?.hasError ??
                                false,
                            child: toolTipBuilder(cubit.phoneTooltipKey,
                                context.el.fieldRequired),
                          );
                        },
                      ),
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
                    ),
                    // validator: FormBuilderValidators.compose([
                    //   // Phone number is now optional, removed required validator
                    //   FormBuilderValidators.minLength(10, errorText: ''),
                    //   FormBuilderValidators.maxLength(11, errorText: ''),
                    //   FormBuilderValidators.numeric(errorText: ''),
                    // ]),
                  ),
                ),
              ],
            ),
            const VerticalSpace(height: 10.0),

            // Birthday Picker
            _buildFieldLabel(context.el.birthdayLabel, isRequired: false),
            const CreateAccountBirthdayPicker(),

            const VerticalSpace(height: 15.0),

            // Required fields note
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                context.el.fieldsMarkedRequired,
                style: TextStylesInter.font14BlackRegular.copyWith(
                  color: ColorsManager.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: 12.sp,
                ),
              ),
            ),

            const VerticalSpace(height: 15.0),

            // Create Account Button
            bottomCreateAccount(
              context: context,
              onPressed: () {
                validateThenRegister(context);
              },
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

  // Method to build field label with optional required indicator
  Widget _buildFieldLabel(String labelText, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStylesInter.font14BlackRegular,
          ),
          if (isRequired)
            const Text(
              ' *',
              style: TextStyle(
                color: ColorsManager.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        ],
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
      {required BuildContext context, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: ColorsManager.white,
        child: AppTextButton(
          buttonText: context.el.createAccountButton,
          textStyle: TextStylesInter.font15WhiteRegular,
          borderRadius: 5,
          buttonWidth: 200.w,
          onPressed: onPressed,
        ),
      ),
    );
  }

  void validateThenRegister(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    if (cubit.formKey.currentState!.saveAndValidate()) {
      cubit.emitRegisterStates(
        fullName:
            cubit.formKey.currentState?.fields[FormFieldsKeys.fullName]?.value,
        email: cubit.formKey.currentState?.fields[FormFieldsKeys.email]?.value,
        password:
            cubit.formKey.currentState?.fields[FormFieldsKeys.password]?.value,
        phone: cubit.formKey.currentState?.fields[FormFieldsKeys.phone]?.value,
      );
    } else {
      showToastWidget(
        StyledToastWidget(
          message: context.el.formAllFieldRequired,
          icon: Icons.error_outline,
          color: ColorsManager.red.withGreen(20).withBlue(20).withRed(230),
        ),
        context: context,
        axis: Axis.horizontal,
        alignment: Alignment.center,
        position: StyledToastPosition.top,
        reverseAnimation: StyledToastAnimation.slideFromTopFade,
        animation: StyledToastAnimation.slideFromTopFade,
        duration: const Duration(milliseconds: 1500),
      );
    }
  }
}
