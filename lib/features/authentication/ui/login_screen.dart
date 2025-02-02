import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';

import '../../../core/theming/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Handles keyboard overflow
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Sign In',
                style: GoogleFonts.inter(
                  fontSize: 17.0.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.mainRose,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.5,
                    ),
                  ),
                  labelStyle: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.grey,
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.5,
                    ),
                  ),
                  labelStyle: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.grey,
                  ),
                ),
                obscureText: true, // Hide password
              ),
              SizedBox(height: 18.h),
              ElevatedButton(
                onPressed: () {
                  context.pushNamedAndRemoveUntil(
                    Routes.homeLayout,
                    predicate: (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: AlignmentDirectional.center,
                  backgroundColor: ColorsManager.mainRose,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.white,
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.forgetPasswordScreen);
                    },
                    child: Text(
                      'Forget Password?',
                      style: GoogleFonts.inter(
                        fontSize: 13.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.createAccountScreen);
                    },
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.inter(
                        fontSize: 13.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign in with',
                style: GoogleFonts.inter(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Use InkWell or GestureDetector for tap events
                  InkWell(
                    onTap: () {
                      // Handle Apple sign in
                    },
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(6),
                      color: ColorsManager.black,
                      child: SvgPicture.asset(
                        'assets/svgs/apple.svg',
                        height: 40.0.h,
                      ),
                    ), // Replace with your asset path
                  ),
                  SizedBox(width: 18.w),
                  InkWell(
                    onTap: () {
                      // Handle Google sign in
                    },
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(6),
                      color: ColorsManager.white,
                      child: SvgPicture.asset(
                        'assets/svgs/google.svg',
                        height: 40.0.h,
                      ),
                    ), // Replace with your asset path
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
