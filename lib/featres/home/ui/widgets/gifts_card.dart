import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';

class GiftsCardBuilder extends StatelessWidget {
  final List prices;
  final List names;
  final String buttonText;
  final Function onButtonTap;
  const GiftsCardBuilder({
    super.key,
    required this.prices,
    required this.names,
    required this.buttonText,
    required this.onButtonTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      // Stretch across screen
      children: [
        // 2. Product Grid
        Column(
          children: [
            // Product Box 1
            Row(
              children: [
                _buildProductBox(
                  price: prices[0],
                  name: names[0],
                  context: context,
                ),
                const Spacer(),
                // Product Box 2
                _buildProductBox(
                  price: prices[1],
                  name: names[1],
                  context: context,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            // Product Box 3
            Row(
              children: [
                _buildProductBox(
                  price: prices[2],
                  name: names[2],
                  context: context,
                ),
                const Spacer(),

                // Product Box 4
                _buildProductBox(
                  price: prices[3],
                  name: names[3],
                  context: context,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 3. Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Button background
              foregroundColor: Colors.teal.shade700, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(
                  color: Colors.teal, // Button border
                  width: 1.0, // Button border width
                ),
              ),
            ),
            onPressed: () {
              onButtonTap();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                buttonText,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 14.0.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductBox({
    required int price,
    required String name,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for the product images
          Container(
            width: context.pOW(35).w,
            height: context.pOH(12.5).h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 10),

          // Price
          Text.rich(
            TextSpan(
                text: 'SAR ',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: Colors.teal,
                  fontSize: 11.sp,
                ),
                children: [
                  TextSpan(
                    text: '$price',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 13.sp,
                    ),
                  ),
                ]),
          ),

          // Product Name
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
