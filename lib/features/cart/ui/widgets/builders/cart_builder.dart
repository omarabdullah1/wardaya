import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/features/cart/data/apis/cart_api_constants.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_state.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_state.dart';
import 'package:wardaya/features/cart/logic/giftCards/gift_cards_cubit.dart';
import 'package:wardaya/features/cart/ui/widgets/delivery_banner.dart';
import 'package:wardaya/features/cart/ui/widgets/proceed_payment_button.dart';
import 'package:wardaya/features/cart/data/models/get_gift_cards_response.dart'
    as gift_card_response;

import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../logic/addToCart/cubit/add_to_cart_cubit.dart';
import '../../../logic/removeCart/cubit/remove_cart_cubit.dart';
import '../empty_cart.dart';
import '../gift_card_section.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final giftCubit = context.read<GiftCardsCubit>();
        final gift_card_response.GiftCardTemplate? selectedCard =
            cartCubit.selectedCardIndex != -1
                ? giftCubit.state.whenOrNull(
                    initial: () {
                      log("GiftCardCubit initial state");
                      return null;
                    },
                    loaded: (giftCards) =>
                        giftCards[cartCubit.selectedCardIndex]
                            as gift_card_response.GiftCardTemplate?,
                  )
                : null;

        final signatureImage = cartCubit.signature;

        return Scaffold(
          backgroundColor: ColorsManager.offWhite,
          appBar: AppBar(
            backgroundColor: ColorsManager.offWhite,
            title: BlocConsumer<GetCartCubit, GetCartState>(
              listener: (context, state) {
                state.maybeWhen(
                  loading: () {
                    // Show loading indicator if needed
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const LoadingWidget(
                          loadingState: true,
                        ),
                      );
                    });
                  },
                  loaded: (response) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  },
                  error: (message) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, getCartState) {
                return getCartState.maybeWhen(
                  loaded: (cartItems) => cartItems.isNotEmpty
                      ? Text(
                          "${context.el.cartTitle} (${cartItems.length})",
                          style: GoogleFonts.inter(
                            color: ColorsManager.mainRose,
                            fontSize: 22.0.sp,
                            fontWeight: FontWeightHelper.bold,
                          ),
                        )
                      : Text(
                          context.el.cartTitle,
                          style: GoogleFonts.inter(
                            color: ColorsManager.mainRose,
                            fontSize: 22.0.sp,
                            fontWeight: FontWeightHelper.bold,
                          ),
                        ),
                  orElse: () => Text(
                    "${context.el.cartTitle} (0)",
                    style: GoogleFonts.inter(
                      color: ColorsManager.mainRose,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: const ProceedPaymentButton(),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<GetCartCubit>().getCart();
              context.read<GiftCardsCubit>().getGiftCards();
            },
            child: BlocBuilder<GetCartCubit, GetCartState>(
              builder: (context, state) {
                return state.maybeWhen(
                  initial: () => const SizedBox.shrink(),
                  loading: () => _buildLoading(
                    cartItems: [],
                    context: context,
                    selectedCard: selectedCard,
                    signatureImage: signatureImage,
                    cartCubit: cartCubit,
                  ),
                  error: (message) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                    return Center(
                      child: Text(
                        message,
                        style: GoogleFonts.inter(color: ColorsManager.mainRose),
                      ),
                    );
                  },
                  loaded: (cartItems) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                    if (cartItems.isEmpty) {
                      return const EmptyCart();
                    }

                    return _buildSuccess(
                      cartItems: cartItems,
                      context: context,
                      selectedCard: selectedCard,
                      signatureImage: signatureImage,
                      cartCubit: cartCubit,
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccess({
    required List<GetCartItem> cartItems,
    required BuildContext context,
    required gift_card_response.GiftCardTemplate? selectedCard,
    Uint8List? signatureImage,
    required CartCubit cartCubit,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Free Delivery Banner
            DeliveryBanner(cartItems: cartItems),
            VerticalSpace(height: 8.h),

            // Cart Items
            ...cartItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 80.w,
                          height: 80.h,
                          child: item.product.images.isNotEmpty == true
                              ? CachedNetworkImage(
                                  imageUrl:
                                      CartApiConstants.apiBaseUrlForImages +
                                          item.product.images.first,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: SvgPicture.asset(
                                      Assets.of(context).svgs.small_logo_svg,
                                      height: 80.h,
                                      width: 80.w,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: SvgPicture.asset(
                                      Assets.of(context).svgs.small_logo_svg,
                                      colorFilter: const ColorFilter.mode(
                                        ColorsManager.lightGrey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.title ?? 'Unnamed Product',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0.sp,
                                  color: ColorsManager.mainRose,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: ColorsManager.lightGrey,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.w,
                                          vertical: 2.0.h,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (item.quantity >= 1) {
                                                  context
                                                      .read<RemoveCartCubit>()
                                                      .removeFromCart(
                                                        item.product.productId,
                                                      );
                                                }
                                              },
                                              child: SvgPicture.asset(
                                                Assets.of(context)
                                                    .svgs
                                                    .remove_svg,
                                                height: 18.h,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0.w),
                                              child: Text(
                                                '${item.quantity}',
                                                style: GoogleFonts.inter(
                                                  color: ColorsManager.mainRose,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.0.sp,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<AddToCartCubit>()
                                                    .addToCart(
                                                      item.product.productId,
                                                      1,
                                                      item.bundleItems
                                                          .map((e) =>
                                                              e.toString())
                                                          .toList(),
                                                    );
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: ColorsManager.mainRose,
                                                size: 18.0.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text.rich(
                                    TextSpan(
                                      text: '${context.el.currencySar} ',
                                      style: GoogleFonts.inter(
                                        color: ColorsManager.mainRose,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.0.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: (item.product.price.total *
                                                  item.quantity)
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.inter(
                                            color: ColorsManager.mainRose,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13.0.sp,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Gift Card & Message Section
            const SizedBox(height: 16),
            const GiftCardSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading({
    required List<GetCartItem> cartItems,
    required BuildContext context,
    gift_card_response.GiftCardTemplate? selectedCard,
    Uint8List? signatureImage,
    required CartCubit cartCubit,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(
          loadingState: true,
        ),
      );
    });
    return Skeletonizer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Free Delivery Banner
              DeliveryBanner(cartItems: cartItems),
              SizedBox(height: 8.h),

              // Cart Items
              ...cartItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorsManager.lightGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 100,
                            height: 100,
                            child: item.product.images.isNotEmpty == true
                                ? Image.network(
                                    item.product.images.first,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.title ?? 'Unnamed Product',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0.sp,
                                    color: ColorsManager.mainRose,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: ColorsManager.lightGrey,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w,
                                            vertical: 2.0.h,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (item.quantity >= 1) {
                                                    context
                                                        .read<RemoveCartCubit>()
                                                        .removeFromCart(
                                                          item.product
                                                              .productId,
                                                        );
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                  Assets.of(context)
                                                      .svgs
                                                      .remove_svg,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0.w),
                                                child: Text(
                                                  '${item.quantity}',
                                                  style: GoogleFonts.inter(
                                                    color:
                                                        ColorsManager.mainRose,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15.0.sp,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<AddToCartCubit>()
                                                      .addToCart(
                                                        item.product.productId,
                                                        1,
                                                        item.bundleItems
                                                            .map((e) =>
                                                                e.toString())
                                                            .toList(),
                                                      );
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: ColorsManager.mainRose,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text.rich(
                                      TextSpan(
                                        text: '${context.el.currencySar} ',
                                        style: GoogleFonts.inter(
                                          color: ColorsManager.mainRose,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.0.sp,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: (item.product.price.total *
                                                    item.quantity)
                                                .toStringAsFixed(2),
                                            style: GoogleFonts.inter(
                                              color: ColorsManager.mainRose,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.0.sp,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Gift Card & Message Section
              const SizedBox(height: 16),
              const GiftCardSection(),
            ],
          ),
        ),
      ),
    );
  }
}
