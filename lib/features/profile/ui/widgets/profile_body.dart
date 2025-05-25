import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/router_imports.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/blocs/general/cubit/general_cubit.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/theming/colors.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                child: SvgPicture.asset(
                    Assets.of(context).svgs.profile_avatar_svg),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getUserName(context),
                    style: TextStylesInter.font14BlackRegular,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.editProfileScreen,
                        arguments: {'cubit': context.read<ProfileCubit>()},
                      ).then((result) {
                        if (result == true) {
                          if (context.mounted) {
                            context.read<ProfileCubit>().getProfile(context);
                          }
                        }
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.of(context).svgs.edit_pen_svg),
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
                  context.el.myOrders,
                  Assets.of(context).svgs.orders_truck_svg,
                  onTap: () async {
                    context.pushNamed(Routes.myOrdersScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.mySubscriptions,
                  Assets.of(context).svgs.subscription_svg,
                  onTap: () {
                    context.pushNamed(Routes.susbcriptionsScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.invoices,
                  Assets.of(context).svgs.invoices_svg,
                  onTap: () {
                    context.pushNamed(Routes.invoicesScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.savedAddresses,
                  Assets.of(context).svgs.addresses_svg,
                  onTap: () {
                    context.pushNamed(Routes.addressesScreen);
                  },
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.occasions,
                  Assets.of(context).svgs.occassions_svg,
                  onTap: () => context.pushNamed(Routes.occasionsScreen),
                ),
                const Divider(
                  color: ColorsManager.lightGrey,
                  height: 0.0,
                ),
                _buildOptionRow(
                  context,
                  context.el.favouriteGifts,
                  Assets.of(context).svgs.fav_gifs_svg,
                  onTap: () {
                    context.pushNamed(Routes.favoritesScreen);
                  },
                ),
              ],
            ),
          ),
        ),
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
                  context.el.wardayaPoints,
                  Assets.of(context).svgs.points_svg,
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
                        getPoints(context),
                        style: TextStylesInter.font12BlackBold,
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
                  Assets.of(context).svgs.wallet_svg,
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
                        getWallet(context),
                        style: TextStylesInter.font12BlackBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              ],
            ),
          ),
        ),
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
                  context.el.logout,
                  Assets.of(context).svgs.logout_svg,
                  onTap: () {
                    SharedPrefHelper.removeSecuredString(
                        SharedPrefKeys.userToken);
                    SharedPrefHelper.removeSecuredString(
                        SharedPrefKeys.userAreaId);
                    SharedPrefHelper.removeSecuredString(SharedPrefKeys.userID);
                    isLoggedInUser = false;
                    context.read<LayoutCubit>().close();
                    context.pushNamedAndRemoveUntil(
                      Routes.homeLayout,
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
                  Assets.of(context).svgs.delete_account_svg,
                  color: ColorsManager.red,
                  onTap: () {
                    _showDeleteAccountConfirmationDialog(context);
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

  String getUserName(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String userName = '';
    cubit.state.whenOrNull(success: (profile) {
      userName = '${profile.firstName} ${profile.lastName}';
    });
    return userName;
  }

  String getWallet(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String wallet = '';
    cubit.state.whenOrNull(success: (profile) {
      wallet = '${profile.wallet!.currency} ${profile.wallet!.total}';
    });
    return wallet;
  }

  String getPoints(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    String points = '';
    cubit.state.whenOrNull(success: (profile) {
      points = profile.points.toString();
    });
    return points;
  }

  void _showDeleteAccountConfirmationDialog(BuildContext context) {
    // Store reference to the original context that has access to ProfileCubit
    final outerContext = context;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(outerContext.el.deleteAccount),
          content: Text(outerContext.el.deleteAccountConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(outerContext.el.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                outerContext.el.confirm,
                style: const TextStyle(color: ColorsManager.red),
              ),
              onPressed: () {
                // Close dialog first
                Navigator.of(dialogContext).pop();

                // Call the deleteAccount method from ProfileCubit using the original context
                outerContext.read<ProfileCubit>().deleteAccount(outerContext);
              },
            ),
          ],
        );
      },
    );
  }
}
