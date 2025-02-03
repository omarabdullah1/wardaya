import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/theming/colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          // Handles keyboard overflow
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Forget Password?',
                style: GoogleFonts.inter(
                  fontSize: 27.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkGray,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Enter the email address associated with your account',
                style: GoogleFonts.inter(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.grey,
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
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsManager.grey,
                      width: 1.0,
                    ),
                  ),
                  labelStyle: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.grey,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              ElevatedButton(
                onPressed: () {
                  // Handle sign in
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(context.screenWidth.w, 40.h),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: AlignmentDirectional.center,
                  backgroundColor: ColorsManager.mainRose,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  'Reset Password',
                  style: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
