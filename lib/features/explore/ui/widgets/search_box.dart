import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.searchScreen);
      },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 2.0,
        child: Container(
          height: 50.0.h,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.search,
                color: ColorsManager.mainRose,
              ),
              SizedBox(width: 8.w),
              Text(
                context.el.exploreSearchHint,
                style: GoogleFonts.inter(
                  color: ColorsManager.lightGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
