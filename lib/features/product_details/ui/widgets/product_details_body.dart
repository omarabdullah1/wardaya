import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/constants.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/product_details/data/apis/product_details_api_constants.dart';
import 'package:wardaya/features/product_details/data/models/product_response.dart';

class ProductDetailsBody extends StatefulWidget {
  final ProductResponse product;

  final VoidCallback onAddToCart;

  const ProductDetailsBody({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int _currentImageIndex = 0;
  bool _isDescriptionTab = true; // Controls which tab is selected
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool showTabs =
        widget.product.careTips.isNotEmpty && !widget.product.isBundle;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: ColorsManager.transparent,
                      height: context.pOH(30).h,
                      child: PageView.builder(
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl:
                                ProductDetailsApiConstants.apiBaseUrlForImages +
                                    widget.product.images[index],
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Center(
                              child: SvgPicture.asset(
                                Assets.of(context).svgs.small_logo_svg,
                                height: 120.h,
                                width: 120.w,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: SvgPicture.asset(
                                Assets.of(context).svgs.small_logo_svg,
                                height: 120.h,
                                width: 120.w,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.product.images.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            height: 7.h,
                            width: 7.w,
                            decoration: BoxDecoration(
                              color: _currentImageIndex == index
                                  ? ColorsManager.mainRose
                                  : ColorsManager.grey.withAlpha(128),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Price and Points
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: context.read<GeneralCubit>().lang ==
                            Constants.arLang
                        ? [
                            Text.rich(
                              TextSpan(
                                  text: '${widget.product.price.total} ',
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
                                  Assets.of(context)
                                      .svgs
                                      .wardaya_points_icon_svg,
                                  colorFilter: const ColorFilter.mode(
                                      ColorsManager.mainRose, BlendMode.srcIn),
                                  height: 24.h,
                                ),
                                SizedBox(width: 11.w),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        '${context.el.earn} ${widget.product.points} \n',
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
                                      text: ' ${widget.product.price.total}',
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
                                  Assets.of(context)
                                      .svgs
                                      .wardaya_points_icon_svg,
                                  colorFilter: const ColorFilter.mode(
                                      ColorsManager.mainRose, BlendMode.srcIn),
                                  height: 24.h,
                                ),
                                SizedBox(width: 11.w),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        '${context.el.earn}${widget.product.points} \n',
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
                    widget.product.title,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Bundle Items Section
                if (widget.product.isBundle ||
                    widget.product.bundleItems.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpace(height: 16),
                        Text(
                          'What\'s included in your bundle',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.darkGray,
                          ),
                        ),
                        const VerticalSpace(height: 8),
                        Text(
                          'Customizable items (${widget.product.bundleItems.length})',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: ColorsManager.darkGray,
                          ),
                        ),
                        const VerticalSpace(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.product.bundleItems.length,
                          separatorBuilder: (context, index) =>
                              const VerticalSpace(height: 12),
                          itemBuilder: (context, index) {
                            final bundleItem =
                                widget.product.bundleItems[index];
                            // Filter out any empty categories
                            final categories = bundleItem.categories
                                .where((cat) => cat.categoryTitle.isNotEmpty)
                                .toList();

                            if (categories.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              separatorBuilder: (_, __) =>
                                  const VerticalSpace(height: 8),
                              itemBuilder: (context, catIndex) {
                                final category = categories[catIndex];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 8.h),
                                    title: Text(
                                      category.categoryTitle,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: const Icon(Icons.chevron_right),
                                    onTap: () {
                                      // Handle bundle item customization
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const VerticalSpace(height: 16),
                      ],
                    ),
                  ),

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

                // Only show tabs and content if there are care tips and not a bundle
                if (showTabs) ...[
                  // Description and Care Tips tabs
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                setState(() => _isDescriptionTab = true),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: _isDescriptionTab
                                        ? ColorsManager.mainRose
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Description',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _isDescriptionTab
                                      ? ColorsManager.mainRose
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                setState(() => _isDescriptionTab = false),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: !_isDescriptionTab
                                        ? ColorsManager.mainRose
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Care Tips',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !_isDescriptionTab
                                      ? ColorsManager.mainRose
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content area with expandable text
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isDescriptionTab
                              ? widget.product.description
                              : widget.product.careTips,
                          maxLines: _isExpanded ? null : 3,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isExpanded = !_isExpanded),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isExpanded
                                    ? context.el.seeLess
                                    : context.el.seeMore,
                                style: const TextStyle(
                                  color: ColorsManager.mainRose,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: ColorsManager.mainRose,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Show only description without tabs if no care tips or is a bundle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(context.el.descriptionHeader,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.sp,
                        )),
                  ),
                  VerticalSpace(height: 8.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: ColorsManager.lightGrey,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.description,
                          maxLines: _isExpanded ? null : 3,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isExpanded = !_isExpanded),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isExpanded
                                    ? context.el.seeLess
                                    : context.el.seeMore,
                                style: const TextStyle(
                                  color: ColorsManager.mainRose,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: ColorsManager.mainRose,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

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
                                    Assets.of(context)
                                        .pay_cards
                                        .master_card_png,
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
                // const Padding(
                //   padding: EdgeInsets.all(16.0),
                //   child: MakeItPerfectSection(),
                // ),
                const VerticalSpace(height: 16),
              ],
            ),
          ),
        ),
        // Bottom Bar with Add to Cart Button
        Container(
          color: ColorsManager.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: widget.onAddToCart,
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
      ],
    );
  }
}
