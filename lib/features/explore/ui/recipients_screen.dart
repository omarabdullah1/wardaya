import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/helpers/dummy_vars.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';

class RecipientsScreen extends StatelessWidget {
  final BuildContext cartContext;
  const RecipientsScreen({super.key, required this.cartContext});

  @override
  Widget build(BuildContext context) {
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
          context.el.recipientsScreenTitle,
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
            childAspectRatio: 0.8, // Aspect ratio of grid items (square)
          ),
          itemCount: recipients.length,
          itemBuilder: (context, index) {
            return _buildRecipientItem(
                context, recipients[index], recipientsImages(context)[index]);
          },
        ),
      ),
    );
  }

  Widget _buildRecipientItem(
      BuildContext context, String recipient, String recipientImage) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.categoryScreen,
            arguments: [recipient, cartContext]);
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
            child: Center(
              child: Image.asset(
                recipientImage,
              ),
            ),
          ),
          SizedBox(height: 8.0.h), // Add spacing between image and text
          SizedBox(
            width: context.pOW(25).w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                recipient,
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
