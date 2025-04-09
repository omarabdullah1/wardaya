import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_cubit.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_state.dart';
import 'package:wardaya/features/explore/data/models/menu_items_response.dart';

import '../../../../core/widgets/loading_widget.dart';
import 'category_button.dart';

class MenuItemsBuilder extends StatelessWidget {
  const MenuItemsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _buildLoading(context),
          success: (menuItemsResponse) =>
              _buildSuccess(context, menuItemsResponse),
          failure: (error) => _buildError(error, context),
          orElse: () => _buildFallback(context),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    // Schedule the dialog to be shown after the current build phase completes
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
      enabled: true,
      child: Column(
        children: [
          CategoryButton(
            text: "Flowers & Plants",
            imagePath: "",
            onTap: () {},
          ),
          const SizedBox(height: 10),
          CategoryButton(
            text: "Flowers & Gifts",
            imagePath: "",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(
      BuildContext context, MenuItemsResponse menuItemsResponse) {
    if (menuItemsResponse.menuItems.isEmpty) {
      return const SizedBox.shrink();
    }
    // Schedule pop to happen after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
    return Column(
      children: menuItemsResponse.menuItems.map((menuItem) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: CategoryButton(
            text: menuItem.name,
            imagePath: menuItem.imageUrl,
            onTap: () {
              context.pushNamed(
                Routes.subMenuItemsScreen,
                arguments: {
                  'context': context,
                  'menuItem': menuItem,
                },
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildError(String error, BuildContext context) {
    // Schedule pop to happen after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    return Center(
      child: Text(
        'Error: $error',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    // Schedule pop to happen after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    return Column(
      children: [
        CategoryButton(
          text: context.el.exploreCategoryFlowersPlants,
          imagePath: Assets.of(context).images.flowersAndPlants_png,
          onTap: () {
            // Create a mock MenuItem for the fallback
            final mockMenuItem = MenuItem(
              id: "fallback_flowers",
              name: context.el.exploreCategoryFlowersPlants,
              imageUrl: Assets.of(context).images.flowersAndPlants_png,
              subMenuItems: [],
            );

            context.pushNamed(
              Routes.subMenuItemsScreen,
              arguments: {
                'context': context,
                'menuItem': mockMenuItem,
              },
            );
          },
        ),
        const SizedBox(height: 10),
        CategoryButton(
          text: context.el.exploreCategoryFlowersGifts,
          imagePath: Assets.of(context).images.flowersAndGifts_png,
          onTap: () {
            // Create a mock MenuItem for the fallback
            final mockMenuItem = MenuItem(
              id: "fallback_gifts",
              name: context.el.exploreCategoryFlowersGifts,
              imageUrl: Assets.of(context).images.flowersAndGifts_png,
              subMenuItems: [],
            );

            context.pushNamed(
              Routes.subMenuItemsScreen,
              arguments: {
                'context': context,
                'menuItem': mockMenuItem,
              },
            );
          },
        ),
      ],
    );
  }
}
