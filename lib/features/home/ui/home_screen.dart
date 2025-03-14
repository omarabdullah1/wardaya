import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/home/ui/widgets/transparent_app_bar.dart';

import '../../../core/helpers/dummy_vars.dart';
import '../../../core/routing/routes.dart';
import 'widgets/category_progress_scroll.dart';
import 'widgets/discover_ideas_section.dart';
import 'widgets/gifts_card.dart';
import 'widgets/home_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeCarouselSlider(),
            // Gifts For Every Moment Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    context.el.homeGiftsForEveryMoment,
                    style: TextStylesEBGaramond.font32MainRoseRegular,
                  ),
                ),
                verticalSpace(20),
                CategoryProgressScroll(
                  categoriesImages: categoriesImages(context),
                  titles: titles,
                  isBackgroundColor: true,
                ),
              ],
            ),
            verticalSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    context.el.homeExploreUniqueGiftIdeas,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                verticalSpace(20),
                CategoryProgressScroll(
                  categoriesImages: categoriesImages(context),
                  titles: titles,
                  isBackgroundColor: true,
                ),
              ],
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeRoundedBeautyEndlessCharm,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeStartTheYearWithTulips,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeWoodntYouLoveThis,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeAnExtraLuxuriousTouch,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeBestSellers,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: DiscoverIdeasSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeCaptivationAromasOfMubkhar,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeGiftYourLovedOnes,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeNaturesMagic,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.homeLatestAndLoveliest,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: context.el.homeChooseGiftsNow,
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    context.el.homeGiftsForEveryone,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                verticalSpace(20),
                CategoryProgressScroll(
                  categoriesImages: giftsCategoriesImages(context),
                  titles: giftsTitles,
                  isBackgroundColor: false,
                ),
              ],
            ),
            SizedBox(height: context.pOH(1.5).h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    context.el.homeBrandsYoullLove,
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                verticalSpace(20),
                CategoryProgressScroll(
                  categoriesImages: brandsCategoriesImages,
                  titles: brandsTitles,
                  isBackgroundColor: false,
                ),
              ],
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
