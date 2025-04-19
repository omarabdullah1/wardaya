import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';

class DeliveryBanner extends StatelessWidget {
  final List<GetCartItem> cartItems;

  const DeliveryBanner({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final totalAmount = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.product.price.total * item.quantity),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 27.w,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.of(context).svgs.delivery_svg,
            height: 25.h,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                totalAmount >= 300
                    ? context.el.freeDeliveryUnlocked
                    : context.el.freeLabel,
                style: GoogleFonts.inter(
                  color: ColorsManager.mainRose,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0.sp,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: (context.screenWidth * 0.6),
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        height: 5.0.h,
                        child: LinearProgressIndicator(
                          value: (totalAmount / 300).clamp(0.0, 1.0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            ColorsManager.mintGreen,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text.rich(
                      TextSpan(
                        text: context.el.currencySar,
                        style: GoogleFonts.inter(
                          color: ColorsManager.mainRose,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0.sp,
                        ),
                        children: [
                          TextSpan(
                            text: ' 300',
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
