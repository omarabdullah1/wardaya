import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/widgets/app_back_app_bar.dart';
import 'package:wardaya/core/widgets/app_text_button.dart';
import 'package:wardaya/features/authentication/create_account/logic/cubit/register_cubit.dart';
import 'package:wardaya/features/authentication/create_account/ui/widgets/create_account_form.dart';

import '../../../../core/theming/colors.dart';
import '../logic/cubit/register_state.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackAppBar(
        title: context.el.createAccountTitle,
        onBack: () => context.pop(),
      ),
      bottomNavigationBar: bottomCreateAccount(context),
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

  Widget bottomCreateAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: ColorsManager.white,
        child: AppTextButton(
          buttonText: context.el.createAccountButton,
          textStyle: TextStylesInter.font15WhiteRegular,
          borderRadius: 5,
          buttonHeight: 45.h,
          onPressed: () => validateThenDoRegister(context),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final GlobalKey<TooltipState> fullNameTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> emailTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordTooltipKey = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> passwordConfirmationTooltipKey =
      GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return Column(
              children: [
                FormBuilderTextField(
                  name: 'full_name',
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    suffixIcon:
                        _formKey.currentState?.fields['full_name']?.hasError ??
                                false
                            ? toolTipBuilder(fullNameTooltipKey, 'Required')
                            : null,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  key: _emailFieldKey,
                  name: 'email',
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon:
                        _formKey.currentState?.fields['email']?.hasError ??
                                false
                            ? toolTipBuilder(emailTooltipKey, 'Required')
                            : null,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon:
                        _formKey.currentState?.fields['Password']?.hasError ??
                                false
                            ? toolTipBuilder(passwordTooltipKey, 'Required')
                            : null,
                  ),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'confirm_password',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: (_formKey.currentState
                                ?.fields['confirm_password']?.hasError ??
                            false)
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  obscureText: true,
                  validator: (value) =>
                      _formKey.currentState?.fields['password']?.value != value
                          ? 'No coinciden'
                          : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.saveAndValidate()) {
                        if (true) {
                          // Either invalidate using Form Key
                          _formKey.currentState?.fields['email']
                              ?.invalidate('Email already taken.');
                          // OR invalidate using Field Key
                          // _emailFieldKey.currentState?.invalidate('Email already taken.');
                        }
                      }
                      debugPrint(_formKey.currentState?.value.toString());
                    });
                  },
                  child: const Text('Signup'),
                )
              ],
            );
          },
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
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
