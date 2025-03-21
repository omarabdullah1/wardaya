import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';

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
              // Localized title using context.el
              Text(
                context.el.forgetPasswordTitle,
                style: GoogleFonts.inter(
                  fontSize: 27.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkGray,
                ),
                textAlign: TextAlign.center,
              ),
              // Localized instruction text
              Text(
                context.el.forgetPasswordInstruction,
                style: GoogleFonts.inter(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(height: 18),
              // Localized label for email TextField
              TextField(
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
                  labelStyle: GoogleFonts.inter(
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.grey,
                  ),
                ),
              ),
              const VerticalSpace(height: 18),
              // Localized reset password button text
              ElevatedButton(
                onPressed: () {
                  // Handle reset password action
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
                  context.el.resetPasswordButton,
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
