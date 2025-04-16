import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';

import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/favorites/data/apis/favorites_api_constants.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/search/data/models/search_response.dart'
    as search;

import '../../../../core/assets/assets.dart';
import '../../data/models/get_favorites_response.dart';

class FavoriteItemTile extends StatelessWidget {
  final GetFavoriteProduct item;

  const FavoriteItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // Extract properties from GetFavoriteProduct
    final String id = item.id;
    final String name = item.title ?? '';
    final String imageUrl = item.images?.isNotEmpty == true
        ? FavoritesApiConstants.apiBaseUrlForImages + (item.images!.first)
        : '';

    return GestureDetector(
      onTap: () {
        // Convert to search.Product since ProductDetailsScreen expects a search.Product
        context.pushNamed(Routes.productDetailsScreen, arguments: {
          'extraArgs': search.Product(
              id: item.id,
              sku: item.sku ?? '',
              title: item.title ?? '',
              description: item.description ?? '',
              productType: item.productType ?? '',  // Required field
              images: item.images ?? [],
              categories: [],  // Changed from item.categories to empty list
              subCategories: [],  // Changed from item.subCategories to empty list
              expressDelivery: item.expressDelivery ?? false,
              createdAt: item.createdAt != null && item.createdAt!.isNotEmpty
                  ? DateTime.parse(item.createdAt!)
                  : DateTime.now(),
              updatedAt: item.updatedAt != null && item.updatedAt!.isNotEmpty
                  ? DateTime.parse(item.updatedAt!)
                  : DateTime.now(),
              version: 0,
              bundleTypes: [],
              colors: [],
              occasions: [],
              productTypes: [],
              recipients: [],
              components: [],
              menuItems: [],  // Required field for search.Product
              subMenuItems: [], // Required field for search.Product
              bundleItems: [],
              price: search.Price(
                  total: item.price!.total.toDouble(),  // Make sure this is a double
                  currency: item.price!.currency),
              points: item.points,
              freeDelivery: item.freeDelivery ?? false,
              premiumFlowers: item.premiumFlowers ?? false,
              careTips: item.careTips ?? '',
              isBundle: item.isBundle ?? false,
              brand: null,
              dimensions: item.dimensions != null
                  ? search.Dimensions(
                      width: item.dimensions!.width?.toDouble(),
                      height: item.dimensions!.height?.toDouble(),
                    )
                  : null,
          ),
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with heart icon overlay
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200.h,
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: ColorsManager.mainRose,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.of(context).svgs.small_logo_svg,
                                  width: 100.w,
                                  height: 100.w,
                                  colorFilter: const ColorFilter.mode(
                                    ColorsManager.mainRose,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Skeletonizer(
                            child: Container(
                              color: Colors.grey.shade200,
                              child: Center(
                                child: Container(
                                  width: 100.w,
                                  height: 100.w,
                                  color: ColorsManager.mainRose,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<FavoritesCubit>()
                              .removeFromFavorites(id);
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: ColorsManager.mainRose,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Product details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${item.price?.currency} ${item.price?.total}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
