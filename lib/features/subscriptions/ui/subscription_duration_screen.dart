import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../../../core/theming/colors.dart';

class SubscriptionDurationScreen extends StatefulWidget {
  const SubscriptionDurationScreen({super.key});

  @override
  State<SubscriptionDurationScreen> createState() =>
      _SubscriptionDurationScreenState();
}

class _SubscriptionDurationScreenState
    extends State<SubscriptionDurationScreen> {
  String? deliveryFrequency = "Once a week";
  String? subscriptionDuration = "12 Months";
  String? startDate = "Sat, 01/2/25";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: AppBar(
        title: Text(
          "Classic Flowers Subscription",
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
            buildSectionTitle("Delivery Frequency"),
            buildRadioList(
              ["Once a week", "Every two weeks", "Once a month"],
              deliveryFrequency,
              (value) => setState(() => deliveryFrequency = value),
            ),
            buildSectionTitle("Subscription Duration"),
            buildRadioList(
              ["1 Month", "3 Months", "6 Months", "12 Months"],
              subscriptionDuration,
              (value) => setState(() => subscriptionDuration = value),
            ),
            buildSectionTitle("Starting Date"),
            buildRadioList(
              ["Sat, 01/2/25", "Sun, 02/2/25", "Select Other Date"],
              startDate,
              (value) => setState(() => startDate = value),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "We’ll select the best delivery time based on your area and delivery date",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Text("Proceed To Payment",
                  style: TextStyle(color: Colors.white)),
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

  Widget buildRadioList(List<String> options, String? selectedValue,
      Function(String?) onChanged) {
    return Column(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              border: Border.all(
                  color: option == selectedValue
                      ? ColorsManager.mainRose
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RadioListTile<String>(
              title: Text(option,
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontSize: 16.0.sp,
                    fontWeight: option == selectedValue
                        ? FontWeight.bold
                        : FontWeight.normal,
                  )),
              value: option,
              groupValue: selectedValue,
              onChanged: onChanged,
              activeColor: ColorsManager.mainRose,
              overlayColor: WidgetStateProperty.all(ColorsManager.mainRose),
            ),
          ),
        );
      }).toList(),
    );
  }
}
