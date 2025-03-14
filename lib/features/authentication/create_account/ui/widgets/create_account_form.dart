import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../../core/widgets/app_back_app_bar.dart';
import 'register_form.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBackAppBar(
        title: context.el.createAccountTitle,
        onBack: () => context.pop(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: RegisterForm(),
      ),
    );
  }
}
