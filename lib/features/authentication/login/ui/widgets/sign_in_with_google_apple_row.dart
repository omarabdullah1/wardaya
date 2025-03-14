import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/assets/assets.dart';

import '../../../../../core/theming/colors.dart';
import '../../logic/cubit/login_cubit.dart';

class SignInWithGoogleAppleRow extends StatelessWidget {
  const SignInWithGoogleAppleRow({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    // Row with social sign-in icons
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // InkWell(
        //   onTap: cubit.isSigningIn ? null : cubit.handleSignInWithApple,
        //   child: Material(
        //     elevation: 2,
        //     borderRadius: BorderRadius.circular(6),
        //     color: ColorsManager.black,
        //     child: SvgPicture.asset(
        //       Assets.of(context).svgs.apple_svg,
        //       height: 40.0.h,
        //     ),
        //   ),
        // ),
        SizedBox(width: 18.w),
        InkWell(
          onTap: cubit.isSigningIn
              ? null
              : () => cubit.handleSignInWithGoogle(context),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(6),
            color: ColorsManager.white,
            child: SvgPicture.asset(
              Assets.of(context).svgs.google_svg,
              height: 40.0.h,
            ),
          ),
        ),
      ],
    );
  }
}
