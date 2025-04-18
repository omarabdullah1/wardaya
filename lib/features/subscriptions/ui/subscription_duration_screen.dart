// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../../../core/assets/assets.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../logic/plans/subscription_cubit.dart';
import 'widgets/build_radio_list.dart';
import 'widgets/subscription_duration_bloc_listener.dart';

class SubscriptionDurationScreen extends StatelessWidget {
  final String planId;
  final String title;
  final String price;
  final String currency;
  const SubscriptionDurationScreen({
    super.key,
    required this.planId,
    required this.title,
    required this.price,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEE, d/M/yyyy').format(DateTime.now());
    String tommorow = DateFormat('EEE, d/M/yyyy')
        .format(DateTime.now().add(const Duration(days: 1)));
    final cubit = context.watch<SubscriptionCubit>();
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      bottomNavigationBar: Material(
        elevation: 25,
        child: Container(
          color: ColorsManager.white,
          height: 75.h,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                log(cubit.deliveryFrequency.toString());
                log(cubit.subscriptionDuration.toString());
                log(cubit.selectedDate.toString());

                if (cubit.deliveryFrequency == null ||
                    cubit.subscriptionDuration == null ||
                    cubit.selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select all required options'),
                      backgroundColor: ColorsManager.mainRose,
                    ),
                  );
                  return;
                }
                log('message');
                log(cubit.deliveryFrequency.toString());
                log(cubit.subscriptionDuration.toString());
                log(cubit.selectedDate.toString());
                log(price.toString());
                log(currency.toString());
                context.pushNamed(
                  Routes.subscripionCheckout,
                  arguments: {
                    'subscriptionPlan': planId,
                    'deliveryFrequency': cubit.deliveryFrequency,
                    'subscriptionDuration': cubit.subscriptionDuration,
                    'selectedDate': cubit.selectedDate,
                    'price': price,
                    'currency': currency,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainRose,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.sp),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: Text(context.el.proceedToPayment,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          context.el.subscriptionDurationTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 25.0.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: ColorsManager.mainRose,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.offWhite, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildSectionTitle(context.el.deliveryFrequency),
            BuildDeliveryRadioList(
              options: [
                context.el.onceAWeek,
                context.el.everyTwoWeeks,
                context.el.onceAMonth
              ],
            ),
            buildSectionTitle(context.el.subscriptionDuration),
            const SubscriptionDurationBlocListener(),
            buildSectionTitle(context.el.startingDate),
            BuildStartingDateRadioList(
              options: [today, tommorow, context.el.selectOtherDate],
              selectedDate: context.el.selectOtherDate,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.of(context).svgs.info_svg,
                    ),
                    const HorizontalSpace(width: 10),
                    Expanded(
                      child: Text(
                        context.el.weSelectDeleveryBasedArea,
                        style: TextStylesInter.font12BlackBold,
                        textAlign: TextAlign.start,
                      ),
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStylesEBGaramond.font25MainRoseRegular,
      ),
    );
  }
}
