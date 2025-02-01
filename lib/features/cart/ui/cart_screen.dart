import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/layout/logic/cubit/layout_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int itemCount = 1;

  // Initial item count
  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
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
                  "Your Cart is Empty!",
                  style: GoogleFonts.inter(
                    color: ColorsManager.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 21.0.sp,
                  ),
                ),
                Text(
                  "Looks like you havn’t added anything to your cart yet.",
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
                        'Start Shopping',
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
            'Cart ($itemCount)',
            style: GoogleFonts.inter(
              color: ColorsManager.mainRose,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w500,
            ),
          ), // Dynamic count if needed
          centerTitle: true, // Center the title
        ),
        body: SingleChildScrollView(
          // For scrollability if content overflows
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Free Delivery Banner
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 27.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.white, // Light red background
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/delivery.svg',
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🎉 You’ve unlocked free delivery!",
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            width: (context.screenWidth - 130.w),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: SizedBox(
                                    height: 5.0.h,
                                    child: const LinearProgressIndicator(
                                      value: 1.0, // 100% progress
                                      valueColor: AlwaysStoppedAnimation<Color>(
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
                                    text: 'SAR ',
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
                                      borderRadius: BorderRadius.circular(100),
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
                                                if (itemCount > 0) itemCount--;
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              'assets/svgs/remove.svg',
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              '$itemCount',
                                              style: GoogleFonts.inter(
                                                color: ColorsManager.mainRose,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15.0.sp,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                itemCount++;
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
                                      text: 'SAR ',
                                      style: GoogleFonts.inter(
                                        color: ColorsManager.mainRose,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.0.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '${480 * itemCount}',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/gift_card.svg',
                            ),
                            SizedBox(width: 11.w),
                            Text(
                              'Gift Card & Message',
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
                                Container(
                                  width:
                                      context.pOW(context.screenWidth / 11).w,
                                  height: context.pOH(13).h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/cards/empty_card.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Select Gift Card',
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
                                Container(
                                  width:
                                      context.pOW(context.screenWidth / 11).w,
                                  height: (context.pOH(13) - 1.5).h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: const DashedBorder.fromBorderSide(
                                      dashLength: 10,
                                      side: BorderSide(
                                        color: ColorsManager.mainRose,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/small_logo.svg',
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'Tap to add\na message',
                                        style: GoogleFonts.inter(
                                          color: ColorsManager.mainRose,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Add a Message',
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
                                // Handle checkout logic
                              },
                              child: Text(
                                'Customize',
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
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const MakeItPerfectSection()),

                const SizedBox(height: 24),
                // Checkout Button
                SizedBox(
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
                            'Proceed To Payment',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0.sp,
                              color: ColorsManager.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'SAR ${480 * itemCount}',
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
              ],
            ),
          ),
        ),
      );
    }
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
    double screenWidth =
        MediaQuery.of(context).size.width; // For responsiveness

    return Container(
      width: screenWidth * 0.9, // 90% of screen width
      height: 500, // Or calculate height dynamically if needed
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
                ),
                SizedBox(width: 11.w),
                Text(
                  'Make it perfect',
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
                tabs: const [
                  Tab(text: 'Recommended'),
                  Tab(text: 'Flowers Add On'),
                  Tab(text: 'Stickers'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProductGrid(),
                  _buildProductGrid(),
                  _buildProductGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7, // Adjust as needed
      ),
      itemCount: 4, // Replace with your actual item count
      itemBuilder: (context, index) {
        return _buildProductItem();
      },
    );
  }

  Widget _buildProductItem() {
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
                  height: context.pOH(12).h,
                  decoration: BoxDecoration(
                    color: ColorsManager.lightGrey, // Placeholder
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Replace with your Image widget:
                  // child: Image.network('your_image_url', fit: BoxFit.cover),
                  // or
                  // child: Image.asset('your_asset_path', fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 15.0.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'SAR ',
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
                  'Happy Birthday Acrylic Topper - Gold',
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
