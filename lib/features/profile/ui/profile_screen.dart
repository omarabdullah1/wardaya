import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/routing/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          context.el.profileScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 37.0.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            // Profile Header (Name and Picture)
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/svgs/profile_avatar.svg'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belal Assem',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Handle edit profile logic
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svgs/edit_pen.svg'),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Text(
                              context.el.viewEditProfile,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // List of Options
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOptionRow(context, context.el.myOrders,
                        'assets/svgs/orders_truck.svg'),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.mySubscriptions,
                        'assets/svgs/subscription.svg'),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.invoices,
                        'assets/svgs/invoices.svg'),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.savedAddresses,
                        'assets/svgs/addresses.svg'),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.occasions,
                        'assets/svgs/occassions.svg'),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.favouriteGifts,
                        'assets/svgs/fav_gifs.svg'),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOptionRow(
                      context,
                      context.el.wardayaPoints,
                      'assets/svgs/points.svg',
                      showArrow: false,
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 2,
                          ),
                          child: Text(
                            '0',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                              color: ColorsManager.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(
                      context,
                      context.el.wardayaWallet,
                      'assets/svgs/wallet.svg',
                      showArrow: false,
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.offWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 2,
                          ),
                          child: Text(
                            '${context.el.currencySar} 0',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0.sp,
                              color: ColorsManager.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOptionRow(context, context.el.customerCare,
                        'assets/svgs/customer_care.svg', onTap: () {
                      _showCustomerCareBottomSheet(context);
                    }),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(context, context.el.language,
                        'assets/svgs/language.svg',
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOptionRow(
                      context,
                      context.el.faq,
                      'assets/svgs/faq.svg',
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
                      'assets/svgs/tac.svg',
                      onTap: () {
                        context.pushNamed(Routes.tacScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildOptionRow(
                      context,
                      context.el.logout,
                      'assets/svgs/logout.svg',
                      onTap: () {
                        SharedPrefHelper.removeSecuredString(
                            SharedPrefKeys.userToken);
                        context.pushNamedAndRemoveUntil(
                          Routes.loginScreen,
                          predicate: (route) => false,
                        );
                      },
                    ),
                    const Divider(
                      color: ColorsManager.lightGrey,
                      height: 0.0,
                    ),
                    _buildOptionRow(
                      context,
                      context.el.deleteAccount,
                      'assets/svgs/delete_account.svg',
                      color: ColorsManager.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build each option row
  Widget _buildOptionRow(
    BuildContext context,
    String title,
    String svg, {
    bool showArrow = true,
    Widget? trailing,
    VoidCallback? onTap, // Add an onTap callback
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap, // Use the provided onTap callback
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
            color: Colors.white,
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
                'assets/svgs/phone.svg',
              ),
              _buildBottomSheetOptionRow(
                context,
                'WhatsApp',
                'assets/svgs/whatsapp.svg',
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
        // Handle the action for the selected option (Call Us or Email Us)
        context.pop(); // Close the bottom sheet
        if (title == 'Call Us') {
          // Implement call functionality
          log('Calling...');
        } else if (title == 'Email Us') {
          // Implement email functionality
          log('Emailing...');
        }
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
