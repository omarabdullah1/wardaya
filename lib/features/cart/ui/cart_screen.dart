import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/layout/logic/cubit/layout_cubit.dart';

import '../logic/cubit/cart_cubit.dart';
import '../logic/cubit/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> styles = ['Handwritten', 'Typed'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final selectedCard =
            context.read<CartCubit>().selectedCardIndex != -1 &&
                    context.read<CartCubit>().selectedCardIndex <
                        context.read<CartCubit>().cards.length
                ? context
                    .read<CartCubit>()
                    .cards[context.read<CartCubit>().selectedCardIndex]
                : null;
        final signatureImage = cartCubit.signature;

        if (cartCubit.cartItems == 0) {
          return Scaffold(
            backgroundColor: ColorsManager.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/empty_cart.svg',
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      context.el.cartEmptyTitle,
                      style: GoogleFonts.inter(
                        color: ColorsManager.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 21.0.sp,
                      ),
                    ),
                    Text(
                      context.el.cartEmptySubtitle,
                      style: GoogleFonts.inter(
                        color: ColorsManager.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainRose,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          context.read<LayoutCubit>().changeIndex(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            context.el.startShoppingButton,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0.sp,
                              color: ColorsManager.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: ColorsManager.offWhite,
            appBar: AppBar(
              backgroundColor: ColorsManager.offWhite,
              title: Text(
                "${context.el.cartTitle} (${cartCubit.cartItems})",
                style: GoogleFonts.inter(
                  color: ColorsManager.mainRose,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainRose,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                  onPressed: () {
                    // Handle checkout logic
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.el.proceedToPayment,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0.sp,
                            color: ColorsManager.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${context.el.currencySar}${480 * cartCubit.cartItems}",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0.sp,
                                color: ColorsManager.white,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorsManager.white,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Free Delivery Banner
                    Container(
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
                            'assets/svgs/delivery.svg',
                            height: 25.h,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.el.freeDeliveryUnlocked,
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
                                        child: const LinearProgressIndicator(
                                          value: 1.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            ColorsManager.mintGreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: '${context.el.currencySar} ',
                                        style: GoogleFonts.inter(
                                          color: ColorsManager.mainRose,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13.0.sp,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '300',
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
                    ),
                    SizedBox(height: 8.h),

                    // Item Card
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: ColorsManager.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Patchi Elegant Crystal Centerpiece',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0.sp,
                                      color: ColorsManager.mainRose,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: ColorsManager.lightGrey,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0.w,
                                            vertical: 2.0.h,
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (cartCubit.cartItems >
                                                        0) {
                                                      cartCubit.changeLength(
                                                          cartCubit.cartItems -
                                                              1);
                                                    }
                                                  });
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/svgs/remove.svg',
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Text(
                                                  '${cartCubit.cartItems}',
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
                                                  setState(() {
                                                    cartCubit.changeLength(
                                                        cartCubit.cartItems +
                                                            1);
                                                  });
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
                                      const Spacer(),
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
                                              text:
                                                  '${480 * cartCubit.cartItems}',
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
                    const SizedBox(height: 16),

                    // Gift Card & Message
                    Container(
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
                                      'assets/svgs/gift_card.svg',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: const DashedBorder
                                                  .fromBorderSide(
                                                dashLength: 5,
                                                side: BorderSide(
                                                  color: ColorsManager.mainRose,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: 145.w,
                                                height: 125.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: selectedCard != null
                                                      ? DecorationImage(
                                                          image: AssetImage(
                                                            selectedCard[
                                                                'image'],
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                            'assets/images/cards/empty_card.png',
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: const DashedBorder
                                                  .fromBorderSide(
                                                dashLength: 5,
                                                side: BorderSide(
                                                  color: ColorsManager.mainRose,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: 145.w,
                                                height: 125.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svgs/small_logo.svg',
                                                        height: 15.0.h,
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        cartCubit.to,
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: ColorsManager
                                                              .mainRose,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10.0.sp,
                                                        ),
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        cartCubit.message,
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: ColorsManager
                                                              .mainRose,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10.0.sp,
                                                        ),
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.center,
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
                                                                          .read<
                                                                              CartCubit>()
                                                                          .selectedTypingStyle] ==
                                                                      'Handwritten')
                                                                  ? GoogleFonts
                                                                      .corinthia(
                                                                      color: ColorsManager
                                                                          .mainRose,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15.0.sp,
                                                                    )
                                                                  : GoogleFonts
                                                                      .inter(
                                                                      color: ColorsManager
                                                                          .mainRose,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15.0.sp,
                                                                    ),
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                          borderRadius:
                                              BorderRadius.circular(31),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class MakeItPerfectSection extends StatefulWidget {
  const MakeItPerfectSection({super.key});

  @override
  State<MakeItPerfectSection> createState() => _MakeItPerfectSectionState();
}

class _MakeItPerfectSectionState extends State<MakeItPerfectSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9.w,
      height: 500.h,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/ballons.svg',
                  height: 30.h,
                ),
                SizedBox(width: 11.w),
                Text(
                  context.el.makeItPerfect,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0.sp,
                    color: ColorsManager.mainRose,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: ColorsManager.lighterLightGrey,
                dividerColor: ColorsManager.lightLighterGrey,
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0.sp,
                  color: ColorsManager.mainRose,
                ),
                tabs: [
                  Tab(text: context.el.recommendedTab),
                  Tab(text: context.el.flowersAddOnTab),
                  Tab(text: context.el.stickersTab),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProductGrid(context),
                  _buildProductGrid(context),
                  _buildProductGrid(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.w,
        childAspectRatio: 0.7,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildProductItem(context);
      },
    );
  }

  Widget _buildProductItem(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorsManager.lightGrey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: '${context.el.currencySar} ',
                    style: GoogleFonts.inter(
                      color: ColorsManager.mainRose,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0.sp,
                    ),
                    children: [
                      TextSpan(
                        text: '26.00',
                        style: GoogleFonts.inter(
                          color: ColorsManager.mainRose,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.el.productTitle,
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
