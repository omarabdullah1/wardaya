import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../cart/logic/cubit/cart_cubit.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Sample data for moments (replace with your actual data)
    final List<String> moments = [
      "Happy Birthday",
      "Get Well Soon",
      "Graduation",
      "Love You",
      "New Baby Born",
      "Wedding",
      "Housewarming",
      "Happy Anniversary",
      "Congratulations",
      "Thank You",
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
          context.el.momentsScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 30.0.sp,
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
            childAspectRatio: 0.8, // Aspect ratio of grid items (square)
          ),
          itemCount: moments.length, // Number of moments
          itemBuilder: (context, index) {
            return _buildMomentItem(context, moments[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMomentItem(BuildContext context, String moment) {
    return GestureDetector(
      onTap: () {
        context.pushNamedWithCubit(
          Routes.categoryScreen,
          context.read<CartCubit>(),
          arguments: moment,
        );
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
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                moment,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: ColorsManager.mainRose,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0.sp,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
