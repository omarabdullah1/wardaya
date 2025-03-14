import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';

class FlowersGiftsScreen extends StatelessWidget {
  final BuildContext cartContext;
  const FlowersGiftsScreen({super.key, required this.cartContext});
  @override
  Widget build(BuildContext context) {
    // Sample data for moments (replace with your actual data)
    final List<String> flowersGifts = [
      "Chocolates",
      "Cakes",
      "International Perfumes",
      "Jewellery",
      "Watches",
      "Baby & Toys",
      "Coffee & Tea",
      "Skin & Body Care",
      "Spa Voucher",
      "Dates",
      "Baby Jewellery",
      "Arabic Perfume",
      "Chocolates",
      "Cakes",
      "International Perfumes",
    ];
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
          ), // Back button
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          context.el.flowersPlanetsScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 29.0.sp,
          ),
        ),

        backgroundColor:
            ColorsManager.transparent, // Make the AppBar transparent
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 12.0, // Spacing between columns
            mainAxisSpacing: 12.0, // Spacing between rows
            childAspectRatio: 0.7, // Aspect ratio of grid items (square)
          ),
          itemCount: flowersGifts.length, // Number of moments
          itemBuilder: (context, index) {
            return _buildMomentItem(context, flowersGifts[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMomentItem(BuildContext context, String flowersGifts) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.categoryScreen,
            arguments: [flowersGifts, cartContext]);
      },
      child: Column(
        children: [
          Container(
            width: context.pOW(25).w,
            height: context.pOH(8.5).h,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), // Background color of grid item
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
          ),
          SizedBox(height: 8.0.h), // Add spacing between image and text
          SizedBox(
            width: context.pOW(25).w,
            height: context.pOH(4).h,
            child: Text(
              flowersGifts,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
