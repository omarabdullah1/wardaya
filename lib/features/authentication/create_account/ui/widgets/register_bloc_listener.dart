import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../logic/cubit/register_cubit.dart';
import '../../logic/cubit/register_state.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is Loading || current is RegisterSuccess || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierColor: ColorsManager
                  .transparent, // Remove default barrier overlay color
              builder: (context) => Dialog(
                backgroundColor: ColorsManager
                    .transparent, // Make dialog background transparent
                insetPadding: EdgeInsets.zero, // Remove default dialog padding
                child: Container(
                  height: 80.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/logo/loading_gif.gif',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            );
          },
          success: (registerResponse) {
            context.pop();
            context.pop();
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font22MainRoseSemiBold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font22MainRoseSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
