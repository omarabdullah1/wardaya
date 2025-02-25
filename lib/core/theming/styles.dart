import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font22MainRoseSemiBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.mainRose,
  );
}

class TextStylesKammer {
  static TextStyle font35WhiteRegular = TextStyle(
    color: Colors.white,
    fontSize: 35.sp,
    fontWeight: FontWeightHelper.regular,
    fontFamily: 'Kammerlander',
  );
}

class TextStylesInter {
  static TextStyle font17MainRoseBold = GoogleFonts.inter(
    fontSize: 17.0.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.mainRose,
  );
  static TextStyle font15WhiteRegular = GoogleFonts.inter(
    fontSize: 15.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.white,
  );
  static TextStyle font15GreyRegular = GoogleFonts.inter(
    fontSize: 15.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.grey,
  );
  static TextStyle font15DarkGreyRegular = GoogleFonts.inter(
    fontSize: 15.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );
  static TextStyle font14BlackRegular = GoogleFonts.inter(
    fontSize: 14.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.black,
  );
  static TextStyle font13BlackRegular = GoogleFonts.inter(
    fontSize: 13.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.black,
  );
  static TextStyle font12BlackBold = GoogleFonts.inter(
    fontWeight: FontWeightHelper.bold,
    fontSize: 12.0.sp,
    color: ColorsManager.black,
  );
}

class TextStylesEBGaramond {
  static TextStyle font25MainRoseRegular = GoogleFonts.ebGaramond(
    fontSize: 25.0.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.mainRose,
  );
}
