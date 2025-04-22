import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart' as ccp;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:localization/localization.dart';

import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_back_app_bar.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../logic/cubit/profile_cubit.dart';
import '../logic/cubit/profile_state.dart';

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
  final GlobalKey<TooltipState> phoneTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String countryCode = '+966'; // Default country code

  @override
  initState() {
    super.initState();
    fullNameController.text = getFullName(context);
    emailController.text = getEmail(context);
    phoneController.text = getPhone(context);
    // passwordController.text = getPassword(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          updating: () {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingWidget(
                loadingState: true,
              ),
            );
          },
          updateSuccess: (updateResponse) {
            // Close loading dialog if open
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            // Success actions are handled in the cubit
          },
          updateError: (error) {
            // Close loading dialog if open
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            // Error handling is done in the cubit
          },
          orElse: () {
            // Do nothing for other states
          },
        );
      },
      child: Scaffold(
        appBar: AppBackAppBar(
          title: context.el.editProfileTitle,
          onBack: () => context.pop(),
        ),
        bottomNavigationBar: bottomCreateAccount(
          context: context,
          onPressed: () {},
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
                    labelText: context.el.fullNameLabel,
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
                // Phone number field with country code
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
                            setState(() {
                              // Update the country code when user selects a new country
                              if (countryCode.dialCode != null) {
                                this.countryCode = countryCode.dialCode!;
                                log('Selected country code: ${countryCode.dialCode}');
                              }
                            });
                          },
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
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: context.el.phoneNumberLabel,
                          suffixIcon: FormBuilderField(
                            name: 'phone_error_listener',
                            builder: (FormFieldState<dynamic> field) {
                              return Visibility(
                                visible: formKey.currentState?.fields['phone']
                                        ?.hasError ??
                                    false,
                                child:
                                    toolTipBuilder(phoneTooltipKey, 'Required'),
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
                          labelStyle: TextStylesInter.font15GreyRegular,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: ''),
                          FormBuilderValidators.minLength(10, errorText: ''),
                          FormBuilderValidators.maxLength(11, errorText: ''),
                          FormBuilderValidators.numeric(errorText: ''),
                        ]),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // FormBuilderTextField(
                //   name: 'password',
                //   controller: passwordController,
                //   decoration: InputDecoration(
                //     labelText: context.el.passwordLabel,
                //     border: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: ColorsManager.grey,
                //         width: 1.0,
                //       ),
                //     ),
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: ColorsManager.grey,
                //         width: 1.0,
                //       ),
                //     ),
                //     suffixIcon:
                //         formKey.currentState?.fields['Password']?.hasError ??
                //                 false
                //             ? toolTipBuilder(fullNameTooltipKey, 'Required')
                //             : null,
                //     labelStyle: TextStylesInter.font15GreyRegular,
                //   ),
                //   obscureText: true,
                //   validator: FormBuilderValidators.compose([
                //     FormBuilderValidators.required(),
                //     FormBuilderValidators.minLength(6),
                //   ]),
                // ),
              ],
            ),
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
          onPressed: () {
            // Validate form first
            if (formKey.currentState!.saveAndValidate()) {
              // Check phone number validation
              final phoneValue = phoneController.text;
              if (phoneValue.isEmpty) {
                showToastError(context, 'Phone number is required');
                phoneTooltipKey.currentState?.ensureTooltipVisible();
                return;
              }

              if (!RegExp(r'^\d+$').hasMatch(phoneValue)) {
                showToastError(
                    context, 'Phone number should contain only digits');
                phoneTooltipKey.currentState?.ensureTooltipVisible();
                return;
              }

              // Get ProfileCubit to access the splitFullName method
              final cubit = context.read<ProfileCubit>();

              // Split full name into first and last name using the same logic as in registration
              final nameParts =
                  cubit.splitFullName(fullNameController.text.trim());
              final firstName = nameParts['firstName']!;
              final lastName = nameParts['lastName']!;

              // Call ProfileCubit to update the user profile
              cubit.updateUser(
                context,
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneValue,
                countryCode: countryCode.replaceAll(
                    '+', ''), // Remove + from country code
              );

              // Notify that the update process has started
              log('Updating profile with: firstName=$firstName, lastName=$lastName, phoneNumber=$phoneValue, countryCode=$countryCode');
            } else {
              // Show general validation error
              showToastError(context, 'Please fix the errors in the form');
            }
          },
        ),
      ),
    );
  }

  void showToastError(BuildContext context, String message) {
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorsManager.mainRose,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      duration: const Duration(seconds: 4),
      animDuration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
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

  String getPhone(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String phone = '';
    cubit.state.whenOrNull(
      success: (profileResponse) {
        phone = profileResponse.phoneNumber ?? '';
      },
    );
    log(phone);
    return phone;
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
