import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/layout/logic/cubit/layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.of(context).svgs.empty_cart_svg,
            ),
            SizedBox(height: 25.h),
            Text(
              context.el.cartEmptyTitle,
              style: GoogleFonts.inter(
                color: ColorsManager.black,
                fontWeight: FontWeight.w700,
                fontSize: 21.0.sp,
              ),
            ),
            Text(
              context.el.cartEmptySubtitle,
              style: GoogleFonts.inter(
                color: ColorsManager.black,
                fontWeight: FontWeight.w400,
                fontSize: 15.0.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainRose,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (context.mounted) {
                    context.read<LayoutCubit>().changeIndex(0);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    context.el.startShoppingButton,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0.sp,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
