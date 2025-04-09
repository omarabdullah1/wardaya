import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theming/styles.dart';

class FavoritesEmptyView extends StatelessWidget {
  const FavoritesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.of(context).images.empty_favs_png),
            const VerticalSpace(height: 16),
            Text(
              context.el.favoritesEmptyTitle,
              style: TextStylesInter.font14GreyRegular,
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.homeLayout);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainRose,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                context.el.favoritesEmptyButton,
                style: TextStylesInter.font14WhiteSemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
