import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theming/colors.dart';

class SignInWithGoogleAppleRow extends StatelessWidget {
  const SignInWithGoogleAppleRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Row with social sign-in icons
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          // onTap: _isSigningIn ? null : _handleSignInWithApple,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(6),
            color: ColorsManager.black,
            child: SvgPicture.asset(
              'assets/svgs/apple.svg',
              height: 40.0.h,
            ),
          ),
        ),
        SizedBox(width: 18.w),
        InkWell(
          // onTap: _isSigningIn ? null : _handleSignInWithGoogle,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(6),
            color: ColorsManager.white,
            child: SvgPicture.asset(
              'assets/svgs/google.svg',
              height: 40.0.h,
            ),
          ),
        ),
      ],
    );
  }
}
