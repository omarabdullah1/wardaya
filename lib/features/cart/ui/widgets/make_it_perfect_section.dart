import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/colors.dart';

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
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsManager.lightGrey),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.of(context).svgs.ballons_svg,
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
