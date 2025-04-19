import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_state.dart';

class GiftCardSection extends StatelessWidget {
  final dynamic selectedCard;
  final dynamic signatureImage;
  final CartCubit cartCubit;
  final List<String> styles;

  const GiftCardSection({
    super.key,
    this.selectedCard,
    this.signatureImage,
    required this.cartCubit,
    required this.styles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.of(context).svgs.gift_card_svg,
                      height: 30.h,
                    ),
                    SizedBox(width: 11.w),
                    Text(
                      context.el.giftCardMessage,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0.sp,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              Routes.customizeGiftCardScreen,
                              arguments: [0, context],
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const DashedBorder.fromBorderSide(
                                dashLength: 5,
                                side: BorderSide(
                                  color: ColorsManager.mainRose,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: 145.w,
                                height: 125.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: selectedCard != null
                                      ? DecorationImage(
                                          image: AssetImage(
                                            selectedCard['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: AssetImage(
                                            Assets.of(context)
                                                .images
                                                .cards
                                                .empty_card_png,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            context.el.selectGiftCard,
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              Routes.customizeGiftCardScreen,
                              arguments: [1, context],
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const DashedBorder.fromBorderSide(
                                dashLength: 5,
                                side: BorderSide(
                                  color: ColorsManager.mainRose,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: 145.w,
                                height: 125.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.of(context).svgs.small_logo_svg,
                                        height: 15.0.h,
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        cartCubit.to,
                                        style: GoogleFonts.inter(
                                          color: ColorsManager.mainRose,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.0.sp,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        cartCubit.message,
                                        style: GoogleFonts.inter(
                                          color: ColorsManager.mainRose,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.0.sp,
                                        ),
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5.h),
                                      signatureImage != null
                                          ? Image.memory(
                                              signatureImage,
                                              width: 130.w,
                                              height: 35.h,
                                            )
                                          : Text(
                                              cartCubit.from,
                                              style: (styles[context
                                                          .read<CartCubit>()
                                                          .selectedTypingStyle] ==
                                                      'Handwritten')
                                                  ? GoogleFonts.corinthia(
                                                      color: ColorsManager
                                                          .mainRose,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.0.sp,
                                                    )
                                                  : GoogleFonts.inter(
                                                      color: ColorsManager
                                                          .mainRose,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.0.sp,
                                                    ),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            context.el.addMessage,
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(31),
                          side: const BorderSide(
                            color: ColorsManager.mainRose,
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(
                          Routes.customizeGiftCardScreen,
                          arguments: [0, context],
                        );
                      },
                      child: Text(
                        context.el.customizeButton,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.sp,
                          color: ColorsManager.mainRose,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
