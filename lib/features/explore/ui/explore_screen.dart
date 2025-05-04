import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_cubit.dart';
import 'package:wardaya/features/home/ui/widgets/brands_youll_love_builder.dart';

import 'widgets/category_card.dart';
import 'widgets/explore_card_item.dart';
import 'widgets/menu_items_builder.dart';
import 'widgets/search_box.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          context.el.exploreScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 37.0.sp,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor:
            ColorsManager.transparent, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: RefreshIndicator(
        color: ColorsManager.mainRose,
        onRefresh: () async {
          await context.read<ExploreCubit>().getMenuItems();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SearchBox(),
                  VerticalSpace(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExploreCardItem(
                        imagePath: Assets.of(context).images.moments_png,
                        lable: context.el.exploreCardMoments,
                        onTap: () {
                          context.pushNamed(
                            Routes.momentsScreen,
                          );
                        },
                      ),
                      const Spacer(),
                      ExploreCardItem(
                        imagePath: Assets.of(context).images.recipients_png,
                        lable: context.el.exploreCardRecipients,
                        onTap: () {
                          context.pushNamed(
                            Routes.recipientsScreen,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Using the new MenuItemsBuilder widget
                  const MenuItemsBuilder(),
                  SizedBox(height: 20.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryCard(
                          imagePath: Assets.of(context).images.delivery_png,
                          label: context.el.exploreCategoryExpressDelivery,
                          onTap: () {
                            // Navigate to category screen with express delivery flag
                            Map<String, dynamic> arguments = {
                              'expressDelivery': true,
                              'extraArgs':
                                  context.el.exploreCategoryExpressDelivery,
                            };
                            context.pushNamed(
                              Routes.categoryScreen,
                              arguments: arguments,
                            );
                          },
                        ),
                        CategoryCard(
                          imagePath: Assets.of(context).images.subscription_png,
                          label: context.el.exploreCategoryFloralSubscription,
                          onTap: () {
                            // Navigate to subscription screen
                            context.pushNamed(
                              Routes.susbcriptionsScreen,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.el.exploreBrandsYoullLove,
                        style: GoogleFonts.ebGaramond(
                          color: ColorsManager.mainRose,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      const BrandsYoullLoveBuilder(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
