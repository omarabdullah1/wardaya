import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/authentication/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:wardaya/features/authentication/forget_password/logic/cubit/forget_password_state.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: Scaffold(
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
        ),
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (data) {
                // Ensure any loading dialog is dismissed first
                Navigator.of(context).popUntil((route) => route.isFirst);

                context.read<ForgetPasswordCubit>().snackbarShow(
                      context,
                      context.el.passwordResetLinkSent,
                      color: ColorsManager.mintGreen,
                    );
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    context.pop();
                  }
                });
              },
              error: (errorMsg) {
                // Ensure any loading dialog is dismissed first
                Navigator.of(context).popUntil((route) => route.isFirst);

                context.read<ForgetPasswordCubit>().snackbarShow(
                      context,
                      errorMsg,
                      color: ColorsManager.red,
                    );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final cubit = context.read<ForgetPasswordCubit>();

            // Handle loading state like other home builders
            if (state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            )) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingWidget(
                    loadingState: true,
                  ),
                );
              });
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Localized title using context.el
                      Text(
                        context.el.forgetPasswordTitle,
                        style: GoogleFonts.inter(
                          fontSize: 27.0.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const VerticalSpace(height: 40),
                      // Instructions also using localization
                      Text(
                        context.el.forgetPasswordInstruction,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const VerticalSpace(height: 24),
                      // Email Input Field
                      TextField(
                        controller: cubit.emailController,
                        decoration: InputDecoration(
                          labelText: context.el.emailLabel,
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const VerticalSpace(height: 40),
                      // Reset Password Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainRose,
                          minimumSize: Size(double.infinity, 50.0.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          cubit.requestPasswordReset();
                        },
                        child: Text(
                          context.el.resetPasswordButton,
                          style: GoogleFonts.inter(
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
