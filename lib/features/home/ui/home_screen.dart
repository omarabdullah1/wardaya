import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/home/logic/gallery/gallery_cubit.dart';
import 'package:wardaya/features/home/ui/widgets/gallery_builder.dart';
import 'package:wardaya/features/home/ui/widgets/transparent_app_bar.dart';

import '../logic/brands/brands_cubit.dart';
import '../logic/categories/categories_cubit.dart';
import '../logic/delivery_areas/delivery_areas_cubit.dart';
import '../logic/occassions/occassions_cubit.dart';
import '../logic/recipients/recipients_cubit.dart';
import 'widgets/brands_youll_love_builder.dart';
import 'widgets/categories_builder.dart';
import 'widgets/discover_ideas_section.dart';
import 'widgets/gifts_for_every_moment_builder.dart';
import 'widgets/gifts_for_everyone_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(),
      body: RefreshIndicator(
        color: ColorsManager.mainRose,
        onRefresh: () async {
          context.read<CategoriesCubit>().getCategories();
          context.read<GalleryCubit>().getHomeGallery();
          context.read<OccassionsCubit>().getHomeOccassions();
          context.read<BrandsCubit>().getBrands();
          context.read<RecipientsCubit>().getRecipients();
          context.read<DeliveryAreasCubit>().getDeliveryAreas();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GalleryBuilder(),
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
                  const VerticalSpace(height: 20),
                  const GiftsForEveryMomentBuilder(),
                ],
              ),
              const VerticalSpace(height: 20),
              const CategoriesBuilder(),
              const VerticalSpace(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: DiscoverIdeasSection(),
              ),
              const VerticalSpace(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        context.el.homeGiftsForEveryone,
                        style: TextStylesEBGaramond.font32MainRoseRegular,
                      ),
                    ),
                    const VerticalSpace(height: 20),
                    const GiftsForEveryoneBuilder(),
                  ],
                ),
              ),
              const VerticalSpace(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        context.el.homeBrandsYoullLove,
                        style: TextStylesEBGaramond.font32MainRoseRegular,
                      ),
                    ),
                    const VerticalSpace(height: 20),
                    const BrandsYoullLoveBuilder(),
                  ],
                ),
              ),
              const VerticalSpace(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
