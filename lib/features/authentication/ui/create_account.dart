import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _countryCode;
  // Store selected country code

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
        title: Text(
          // Using localized string for the app bar title
          context.el.createAccountTitle,
          style: GoogleFonts.inter(
            fontSize: 17.0.sp,
            fontWeight: FontWeight.w700,
            color: ColorsManager.mainRose,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: ColorsManager.white,
          child: ElevatedButton(
            onPressed: () {
              log(_countryCode.toString());
              context.pushNamed(Routes.loginScreen);
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
              // Using localized text for the button
              context.el.signInButton,
              style: GoogleFonts.inter(
                fontSize: 15.0.sp,
                fontWeight: FontWeight.w400,
                color: ColorsManager.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name TextField using localized label
            TextField(
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
                labelStyle: GoogleFonts.inter(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.grey,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Email TextField using localized label
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
            SizedBox(height: 16.h),
            // Password TextField using localized label
            TextField(
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
                labelStyle: GoogleFonts.inter(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.grey,
                ),
              ),
              // Optionally set obscureText: true if needed.
            ),
            SizedBox(height: 16.h),
            Row(
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
                        _countryCode = countryCode.dialCode;
                      },
                      headerText: context.el.selectCountryLabel,
                      initialSelection: 'EG',
                      favorite: const ['EG', 'SA', 'AE'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: GoogleFonts.inter(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.darkGray,
                      ),
                      headerTextStyle: GoogleFonts.ebGaramond(
                        fontSize: 25.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.mainRose,
                      ),
                      closeIcon: const Icon(
                        Icons.close,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // Phone TextField using localized label
                  child: TextField(
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
                      labelStyle: GoogleFonts.inter(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
