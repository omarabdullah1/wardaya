import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/blocs/general/cubit/general_cubit.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class GuestProfileBody extends StatelessWidget {
  const GuestProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // Sign In Button Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.loginScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.offWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                    side: const BorderSide(
                      color: ColorsManager.mainRose,
                      width: 1.5,
                    ),
                  ),
                  minimumSize: Size(double.infinity, 40.h),
                ),
                child: Text(
                  context.el.signInButton,
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Customer Care & Language Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildOptionRow(context, context.el.customerCare,
                    Assets.of(context).svgs.customer_care_svg, onTap: () {
                  _showCustomerCareBottomSheet(context);
                }),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(context, context.el.language,
                    Assets.of(context).svgs.language_svg,
                    showArrow: false,
                    trailing: Text(
                      context.read<GeneralCubit>().lang == 'ar'
                          ? context.el.arabic
                          : context.el.english,
                      style: GoogleFonts.lusitana(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0.sp,
                        color: ColorsManager.mainRose,
                      ),
                    ), onTap: () {
                  var cubit = context.read<GeneralCubit>();
                  cubit.changeLanguage(cubit.lang == 'ar' ? 'en' : 'ar');
                }),
              ],
            ),
          ),
        ),

        // FAQ & Terms Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildOptionRow(
                  context,
                  context.el.faq,
                  Assets.of(context).svgs.faq_svg,
                  onTap: () {
                    context.pushNamed(Routes.faqScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.termsConditions,
                  Assets.of(context).svgs.tac_svg,
                  onTap: () {
                    context.pushNamed(Routes.tacScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  "Privacy Policy", // Add this to localization files if available
                  Assets.of(context)
                      .svgs
                      .tac_svg, // Reuse the T&C icon or add a new one
                  onTap: () {
                    // Navigate to privacy policy screen if available
                    // For now, we can reuse the T&C screen
                    context.pushNamed(Routes.tacScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to build each option row
  Widget _buildOptionRow(
    BuildContext context,
    String title,
    String svg, {
    bool showArrow = true,
    Widget? trailing,
    VoidCallback? onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svg,
                colorFilter: color != null
                    ? ColorFilter.mode(color, BlendMode.srcIn)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.sp,
                    color: color ?? ColorsManager.darkGray,
                  )),
              const Spacer(),
              if (showArrow)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorsManager.mainRose,
                  size: 20,
                ),
              if (trailing != null && !showArrow) trailing,
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomerCareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: context.pOH(25).h,
          decoration: const BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'We are happy to help you!\nNeed help with something?',
                      style: GoogleFonts.inter(
                        color: ColorsManager.darkGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _buildBottomSheetOptionRow(
                context,
                'Phone Call',
                Assets.of(context).svgs.phone_svg,
              ),
              _buildBottomSheetOptionRow(
                context,
                'WhatsApp',
                Assets.of(context).svgs.whatsapp_svg,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOptionRow(
      BuildContext context, String title, String svg) {
    return InkWell(
      onTap: () {
        context.pop(); // Close the bottom sheet
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(svg),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 18.0.sp,
                color: ColorsManager.darkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
