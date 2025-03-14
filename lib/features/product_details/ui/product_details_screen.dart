import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/search/data/apis/search_api_constants.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

import '../../../core/assets/assets.dart';
import '../../../core/helpers/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      extendBodyBehindAppBar: true, // Extend body behind AppBar
      appBar: const CustomAppBar(),
      bottomNavigationBar: Container(
        color: ColorsManager.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                context
                    .read<CartCubit>()
                    .changeLength(context.read<CartCubit>().cartItems + 1);
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              minimumSize: const Size(double.infinity, 0),
              backgroundColor: ColorsManager.mainRose,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.of(context).svgs.add_cart_svg,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.white, BlendMode.srcIn),
                  height: 24.h,
                ),
                SizedBox(width: 15.w),
                Text(
                  context.el.addToCart,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Container(
              color: ColorsManager.lightGrey,
              height: context.pOH(30).h,
              child: PageView.builder(
                itemCount: product.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    SearchApiConstants.apiBaseUrlForImages +
                        product.images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Price and Points
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: context.read<GeneralCubit>().lang == Constants.arLang
                    ? [
                        Text.rich(
                          TextSpan(
                              text: '${product.price.total} ',
                              style: GoogleFonts.inter(
                                fontSize: 27.0.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(
                                  text: context.el.currencySar,
                                  style: GoogleFonts.inter(
                                    fontSize: 27.0.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.of(context).svgs.wardaya_points_icon_svg,
                              colorFilter: const ColorFilter.mode(
                                  ColorsManager.mainRose, BlendMode.srcIn),
                              height: 24.h,
                            ),
                            SizedBox(width: 11.w),
                            Text.rich(
                              TextSpan(
                                text: '${context.el.earn} ${product.points} \n',
                                style: GoogleFonts.inter(
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: context.el.wardayaPoints,
                                    style: GoogleFonts.inter(
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]
                    : [
                        Text.rich(
                          TextSpan(
                              text: context.el.currencySar,
                              style: GoogleFonts.inter(
                                fontSize: 27.0.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${product.price.total}',
                                  style: GoogleFonts.inter(
                                    fontSize: 27.0.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.of(context).svgs.wardaya_points_icon_svg,
                              colorFilter: const ColorFilter.mode(
                                  ColorsManager.mainRose, BlendMode.srcIn),
                              height: 24.h,
                            ),
                            SizedBox(width: 11.w),
                            Text.rich(
                              TextSpan(
                                text: '${context.el.earn}${product.points} \n',
                                style: GoogleFonts.inter(
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: context.el.wardayaPoints,
                                    style: GoogleFonts.inter(
                                      fontSize: 11.0.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
              ),
            ),
            SizedBox(height: 8.h),

            // hint
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                context.el.allPricesIncludeTax,
                style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.grey),
              ),
            ),
            SizedBox(height: 8.h),

            // Product Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                product.title,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // No Address Hassle
            Container(
              color: ColorsManager.lighterGrey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.of(context).svgs.location_icon_svg,
                      colorFilter: const ColorFilter.mode(
                          ColorsManager.mainRose, BlendMode.srcIn),
                      height: 24.h,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.el.noAddressHassle,
                          style: GoogleFonts.inter(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          context.el.collectAddressText,
                          style: GoogleFonts.inter(
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(context.el.descriptionHeader,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  )),
            ),
            SizedBox(height: 16.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: ColorsManager.black,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                product.description,
                maxLines: _isExpanded ? 5 : 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      Text(
                        _isExpanded ? context.el.seeMore : context.el.seeLess,
                        style: const TextStyle(color: ColorsManager.mainRose),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: !_isExpanded
                            ? Transform.rotate(
                                angle: 270 * -pi / 180,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: ColorsManager.mainRose,
                                  size: 16.sp,
                                ),
                              )
                            : Transform(
                                transform: Matrix4.rotationZ(pi / 2)
                                  ..scale(-1.0),
                                alignment: Alignment.center,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    color: ColorsManager.mainRose, size: 16.sp),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorsManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            context.el.payWith,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                Assets.of(context).pay_cards.mada_png,
                                height: 24.h,
                              ),
                              SizedBox(width: 4.w),
                              Image.asset(
                                Assets.of(context).pay_cards.paypal_png,
                                height: 24.h,
                              ),
                              SizedBox(width: 4.w),
                              Image.asset(
                                Assets.of(context).pay_cards.visa_png,
                                height: 24.h,
                              ),
                              SizedBox(width: 4.w),
                              Image.asset(
                                Assets.of(context).pay_cards.gpay_png,
                                height: 24.h,
                              ),
                              SizedBox(width: 4.w),
                              Image.asset(
                                Assets.of(context).pay_cards.master_card_png,
                                height: 24.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 36.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.el.splitPaymentsWithTamara,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5.sp,
                            ),
                          ),
                          Image.asset(
                            Assets.of(context).pay_cards.tamara_png,
                            height: 12.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.transparent,
      elevation: 0,
      leadingWidth: 45.w, // Set the leadingWidth
      leading: _buildIconButton(icon: Icons.arrow_back_ios_new, () {
        Navigator.pop(context);
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              _buildIconButton(
                svgIcon: SvgPicture.asset(
                  Assets.of(context).svgs.favs_svg,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.black, BlendMode.srcIn),
                  height: 12.h,
                ),
                () {
                  // Handle favorite action
                  // print('favorite action');
                },
              ),
              _buildIconButton(
                svgIcon: SvgPicture.asset(
                  Assets.of(context).svgs.share_svg,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.black, BlendMode.srcIn),
                  height: 12.h,
                ),
                () {
                  // Handle share action
                  // print('share action');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(
    VoidCallback onPressed, {
    Widget? svgIcon,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 30.0.w,
          height: 30.0.h,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white,
              ),
              padding: EdgeInsets.all(6.sp),
              child: icon == null
                  ? svgIcon
                  : Icon(
                      icon,
                      size: 20,
                      color: ColorsManager.black,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
