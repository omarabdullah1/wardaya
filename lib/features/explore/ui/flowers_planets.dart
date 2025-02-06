import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';

class FlowersPlantsScreen extends StatelessWidget {
  final BuildContext cartContext;
  const FlowersPlantsScreen({super.key, required this.cartContext});
  @override
  Widget build(BuildContext context) {
    // Sample data for moments (replace with your actual data)
    final List<String> flowersPlants = [
      "Flowers in Vases",
      "Hand Bouquets",
      "Only Flowers",
      "Tulip",
      "Flowers in Baskets & Trays",
      "Preserved Flowers",
      "Top Table Arrangements",
      "Flowers Sculptures",
      "Plants",
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
          "Flowers & Plants",
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 29.0.sp,
          ),
        ),

        backgroundColor: Colors.transparent, // Make the AppBar transparent
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
          itemCount: flowersPlants.length, // Number of moments
          itemBuilder: (context, index) {
            return _buildMomentItem(context, flowersPlants[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMomentItem(BuildContext context, String flowersPlanets) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.categoryScreen,
            arguments: [flowersPlanets, cartContext]);
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
              flowersPlanets,
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
