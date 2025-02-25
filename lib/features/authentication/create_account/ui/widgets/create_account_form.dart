import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/authentication/create_account/logic/cubit/register_cubit.dart';
import 'package:wardaya/features/authentication/create_account/ui/widgets/register_bloc_listener.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          // Name TextField using localized label
          TextFormField(
            controller: cubit.nameController,
            validator: (value) {
              if (value.isNullOrEmpty()) {
                return 'context.el.nameValidationMessage';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: context.el.nameLabel,
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
          ),
          verticalSpace(16),
          // Email TextField using localized label
          TextFormField(
            controller: cubit.emailController,
            validator: (value) {
              if (value.isNullOrEmpty()) {
                return 'context.el.emailValidationMessage';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: context.el.emailLabel,
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
          ),
          verticalSpace(16),
          // Password TextField using localized label
          TextFormField(
            controller: cubit.passwordController,
            validator: (value) {
              if (value.isNullOrEmpty()) {
                return 'context.el.passwordValidationMessage';
              }
              return null;
            },
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
              labelStyle: TextStylesInter.font15GreyRegular,
            ),
            // Optionally set obscureText: true if needed.
          ),
          verticalSpace(16),
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
                  child: CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
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
                    headerTextStyle: TextStylesEBGaramond.font25MainRoseRegular,
                    closeIcon: const Icon(
                      Icons.close,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                ),
              ),
              Expanded(
                // Phone TextField using localized label
                child: TextFormField(
                  controller: cubit.phoneController,
                  validator: (value) {
                    if (value.isNullOrEmpty()) {
                      return 'context.el.phoneValidationMessage';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: context.el.phoneLabel,
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
                ),
              ),
            ],
          ),
          const RegisterBlocListener(),
        ],
      ),
    );
  }
}
