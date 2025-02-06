import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
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
            // "Gifts For Every Moment" Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Gifts For Every Moment',
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CategoryProgressScroll(
                  categoriesImages: categoriesImages,
                  titles: titles,
                ),
              ],
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Explore Unique Gift Ideas',
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CategoryProgressScroll(
                  categoriesImages: categoriesImages,
                  titles: titles,
                ),
              ],
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rounded Beauty, Endless Charm',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start the Year with Tulips',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Woodn’t You Love This?',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'An Extra Luxurious Touch',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Sellers',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
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
                    'Captivation Aromas of Mubkhar',
                    style: GoogleFonts.ebGaramond(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GiftsCardBuilder(
                    prices: prices,
                    names: names,
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gift your loved ones while stocks last',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nature’s Magic',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest & Loveliest',
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
                    buttonText: 'Choose Gifts Now',
                    onButtonTap: () {
                      context.pushNamed(Routes.categoryScreen,
                          arguments: [names[0], context]);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Gifts for Everyone',
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CategoryProgressScroll(
                  categoriesImages: giftsCategoriesImages,
                  titles: giftsTitles,
                ),
              ],
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Brands You’ll Love',
                    style: GoogleFonts.ebGaramond(
                      color: ColorsManager.mainRose,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CategoryProgressScroll(
                  categoriesImages: brandsCategoriesImages,
                  titles: brandsTitles,
                ),
              ],
            ),
            SizedBox(
              height: context.pOH(1.5).h,
            ),
          ],
        ),
      ),
    );
  }
}
