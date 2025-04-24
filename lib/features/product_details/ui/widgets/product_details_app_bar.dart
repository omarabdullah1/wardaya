import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/helpers/share_service.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_state.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Product product;

  const ProductDetailsAppBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.transparent,
      elevation: 0,
      leadingWidth: 45.w, // Set the leadingWidth
      leading: _buildIconButton(icon: Icons.arrow_back_ios_new, () {
        Navigator.pop(context);
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              BlocConsumer<FavoritesCubit, FavoritesState>(
                listener: (context, state) {
                  // Listeners moved to ProductDetailsBuilder
                },
                builder: (context, state) {
                  bool isFavorite = false;

                  state.maybeMap(
                    addFavoriteSuccess: (loadedState) {
                      isFavorite = context
                          .read<FavoritesCubit>()
                          .isItemFavorite(product.id);
                    },
                    toggleFavorite: (toggleState) {
                      if (toggleState.itemId == product.id) {
                        isFavorite = toggleState.isFavorite;
                      }
                    },
                    getFavoritesSuccess: (getFavoritesState) {
                      isFavorite = context
                          .read<FavoritesCubit>()
                          .isItemFavorite(product.id);
                    },
                    orElse: () {
                      // Default case, check if item is favorite
                      isFavorite = context
                          .read<FavoritesCubit>()
                          .isItemFavorite(product.id);
                    },
                  );

                  return _buildIconButton(
                    svgIcon: isFavorite
                        ? const Icon(
                            Icons.favorite,
                            size: 16,
                            color: ColorsManager.mainRose,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            size: 16,
                            color: ColorsManager.black,
                          ),
                    () {
                      // Check if the product is already in favorites
                      if (isFavorite) {
                        // If it's already a favorite, remove it
                        context
                            .read<FavoritesCubit>()
                            .removeFromFavorites(product.id);
                      } else {
                        // If it's not a favorite, add it
                        context
                            .read<FavoritesCubit>()
                            .addToFavorites(product.id);
                      }
                    },
                  );
                },
              ),
              _buildIconButton(
                svgIcon: SvgPicture.asset(
                  Assets.of(context).svgs.share_svg,
                  colorFilter: const ColorFilter.mode(
                      ColorsManager.black, BlendMode.srcIn),
                  height: 12.h,
                ),
                () {
                  // Use the fixed ShareService to copy product link to clipboard
                  ShareService().shareProduct(
                    context,
                    productId: product.id,
                    productTitle: product.title,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(
    VoidCallback onPressed, {
    Widget? svgIcon,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 30.0.w,
          height: 30.0.h,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.white,
              ),
              padding: EdgeInsets.all(6.sp),
              child: icon == null
                  ? svgIcon
                  : Icon(
                      icon,
                      size: 20,
                      color: ColorsManager.black,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
