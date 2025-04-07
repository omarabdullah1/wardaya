import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/home/data/models/home_category_response.dart';
import 'package:wardaya/features/home/logic/categories/categories_cubit.dart';
import 'package:wardaya/features/home/logic/categories/categories_state.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import 'category_progress_scroll.dart';
import 'grid_product_card.dart';

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({super.key});

  void setupErrorState(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: TextStyles.font22MainRoseSemiBold,
        ),
        backgroundColor: ColorsManager.red,
      ),
    );
  }

  Widget _setupLoading(BuildContext context) {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.el.homeRoundedBeautyEndlessCharm,
              style: TextStylesEBGaramond.font32MainRoseRegular,
            ),
            const SizedBox(height: 20),
            CategoryProgressScroll(
              categoriesImages: List.generate(5, (_) => ''),
              titles: List.generate(5, (_) => 'Loading'),
              isBackgroundColor: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _setupSuccess(BuildContext context, HomeCategoryResponse data) {
    final validCategories = data.categories
        .where((category) => !(category.products.isNullOrEmpty() &&
            category.subCategories.isNullOrEmpty()))
        .toList();

    return Column(
      children: validCategories
          .map(
            (e) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    style: TextStylesEBGaramond.font32MainRoseRegular,
                  ),
                  const VerticalSpace(height: 10),
                  if (!e.subCategories.isNullOrEmpty())
                    CategoryProgressScroll(
                      categoriesImages:
                          e.subCategories.map((sub) => sub.imageUrl).toList(),
                      titles: e.subCategories.map((sub) => sub.name).toList(),
                      isBackgroundColor: true,
                      ids: e.subCategories.map((sub) => sub.id).toList(),
                      sourceType: 'subCategory',
                    )
                  else if (!e.products.isNullOrEmpty())
                    GridProductsCard(
                      products: e.products,
                      buttonText: context.el.homeChooseGiftsNow,
                      onButtonTap: () {
                        context.pushNamed(
                          Routes.categoryScreen,
                          arguments: {
                            'extraArgs': e.name,
                            'categoryId': e.id,
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      builder: (context, state) {
        return state.when(
          loading: () => _setupLoading(context),
          success: (HomeCategoryResponse data) => _setupSuccess(context, data),
          error: (_) => const SizedBox.shrink(),
          initial: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
