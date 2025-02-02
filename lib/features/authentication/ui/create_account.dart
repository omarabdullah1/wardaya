import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
          'Create Account',
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
              'Sign In',
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
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
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
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
              // obscureText: true, // Hide password
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16.0),
                  child: Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: ColorsManager.grey,
                        width: 1.0,
                      ),
                    ),
                    child: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        _countryCode = countryCode.dialCode; // Store the code
                        // print("Selected Country Code: ${_countryCode}");
                      },
                      initialSelection: 'EG', // Default selection (Egypt)
                      favorite: const [
                        'EG',
                        'SA',
                        'AE'
                      ], // Show these as favorites
                      showCountryOnly: false, // Show country name
                      showOnlyCountryWhenClosed: false, // Show only country
                      alignLeft: false, // Align the flag and code to the left
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
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
