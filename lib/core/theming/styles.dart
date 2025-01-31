import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
