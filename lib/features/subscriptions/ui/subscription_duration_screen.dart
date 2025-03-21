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
import '../logic/cubit/subscription_cubit.dart';
import 'widgets/build_radio_list.dart';

class SubscriptionDurationScreen extends StatelessWidget {
  const SubscriptionDurationScreen({super.key});

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

                context.pushNamed(Routes.subscripionCheckout);
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
            BuildSubscriptionRadioList(
              options: const ["1 Month", "3 Months", "6 Months", "12 Months"],
              optionsOffValue: const ["", "10", "35", "15"],
              prices: const ["SAR 159", "SAR 145", "SAR 137", "SAR 129"],
              deliveries: [
                "",
                "12 ${context.el.deliveries} - ${context.el.total} SAR 1,548",
                "24 ${context.el.deliveries} - ${context.el.total} SAR 3,069",
                "48 ${context.el.deliveries} - ${context.el.total} SAR 6,192"
              ],
            ),
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
