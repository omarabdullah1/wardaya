import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wardaya/features/cart/data/apis/cart_api_constants.dart';
import 'package:wardaya/features/cart/data/models/get_gift_cards_response.dart';
import 'package:wardaya/features/cart/logic/giftCards/gift_cards_cubit.dart';
import 'package:wardaya/features/cart/logic/giftCards/gift_cards_state.dart';

import '../../logic/cubit/cart_cubit.dart';

class PreviewBottomSheet extends StatefulWidget {
  final int selectedCardIndex;
  final PageController pageController;
  final BuildContext cartContext;

  const PreviewBottomSheet({
    super.key,
    required this.selectedCardIndex,
    required this.pageController,
    required this.cartContext,
  });

  @override
  State<PreviewBottomSheet> createState() => _PreviewBottomSheetState();
}

class _PreviewBottomSheetState extends State<PreviewBottomSheet> {
  late ValueNotifier<int> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier =
        ValueNotifier<int>(widget.pageController.initialPage);
    widget.pageController.addListener(() {
      if (widget.pageController.page != null) {
        _currentPageNotifier.value = widget.pageController.page!.round();
      }
    });
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 340.h,
            child: PageView(
              controller: widget.pageController,
              onPageChanged: (page) => _currentPageNotifier.value = page,
              children: [
                _buildFrontPreview(widget.cartContext),
                _buildBackPreview(context),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, currentPage, child) {
              return Column(
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    currentPage == 0
                        ? context.el.frontSideLabel
                        : context.el.backSideLabel,
                    style: GoogleFonts.inter(
                      color: ColorsManager.mainRose,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPageIndicator(context, 0, currentPage == 0),
                      _buildPageIndicator(context, 1, currentPage == 1),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildFrontPreview(BuildContext giftCardContext) {
    return BlocBuilder<GiftCardsCubit, GiftCardsState>(
      builder: (context, state) {
        return giftCardContext.read<GiftCardsCubit>().state.maybeWhen(
              loaded: (giftCards) {
                // Make sure the selectedCardIndex is within valid range
                if (widget.selectedCardIndex < 0 ||
                    widget.selectedCardIndex >= giftCards.length) {
                  return _buildNoCardSelectedView(giftCardContext);
                }

                final selectedCard = giftCards[widget.selectedCardIndex];
                return _buildCardPreview(giftCardContext, selectedCard);
              },
              // For all other states, show loading or no card selected view
              orElse: () => _buildNoCardSelectedView(giftCardContext),
            );
      },
    );
  }

  Widget _buildCardPreview(
      BuildContext giftCardContext, GiftCardTemplate card) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CachedNetworkImage(
        imageUrl: CartApiConstants.apiBaseUrlForImages + card.image,
        fit: BoxFit.cover,
        height: 250.h,
        placeholder: (context, url) => Container(
          color: ColorsManager.lighterGrey,
          height: 250.h,
          child: const Center(
            child: CircularProgressIndicator(color: ColorsManager.mainRose),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: ColorsManager.lighterGrey,
          height: 250.h,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.image_not_supported,
                    color: ColorsManager.mainRose),
                SizedBox(height: 4.h),
                Text(
                  'Gift card image',
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoCardSelectedView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          context.el.noCardSelected,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: ColorsManager.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildBackPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorsManager.mainRose.withAlpha(56),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.of(context).svgs.small_logo_svg,
            height: 35.h,
          ),
          SizedBox(height: 15.h),
          Text(
            widget.cartContext.read<CartCubit>().to,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorsManager.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            widget.cartContext.read<CartCubit>().message,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorsManager.black,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          context.watch<CartCubit>().signature != null
              ? Image.memory(
                  context.watch<CartCubit>().signature!,
                  width: 150.w,
                  height: 50.h,
                )
              : Text(
                  widget.cartContext.read<CartCubit>().from,
                  style: widget.cartContext
                              .read<CartCubit>()
                              .selectedTypingStyle ==
                          0
                      ? GoogleFonts.corinthia(
                          color: ColorsManager.black,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        )
                      : GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: ColorsManager.black,
                        ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: 8.h),
          (context.read<CartCubit>().videoLink.isNullOrEmpty())
              ? (!context.read<CartCubit>().linkController.text.isNullOrEmpty())
                  ? Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      decoration: BoxDecoration(
                        color: ColorsManager.mainRose.withAlpha(35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: ColorsManager.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: QrImageView(
                                data: context
                                    .read<CartCubit>()
                                    .linkController
                                    .text,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: context.screenWidth * 0.50.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.el.qrQuestion,
                                    style: GoogleFonts.inter(
                                      color: ColorsManager.mainRose,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    context.el.qrInstruction,
                                    style: GoogleFonts.inter(
                                      color: ColorsManager.mainRose,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
              : Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainRose.withAlpha(35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 80.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: QrImageView(
                            data: CartApiConstants.apiBaseUrlForImages +
                                context.read<CartCubit>().videoLink!,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: context.screenWidth * 0.50.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.el.qrQuestion,
                                style: GoogleFonts.inter(
                                  color: ColorsManager.mainRose,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                context.el.qrInstruction,
                                style: GoogleFonts.inter(
                                  color: ColorsManager.mainRose,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context, int index, bool isCurrent) {
    return InkWell(
      onTap: () {
        widget.pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 8.w,
        height: 8.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrent
              ? ColorsManager.mainRose
              : ColorsManager.lighterLightGrey,
        ),
      ),
    );
  }
}
