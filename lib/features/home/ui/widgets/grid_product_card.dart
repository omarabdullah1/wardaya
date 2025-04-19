import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';
import 'package:wardaya/features/home/data/models/home_category_response.dart';
import 'package:wardaya/features/search/data/models/search_response.dart'
    as search;

import '../../../../core/assets/assets.dart';
import '../../../../core/routing/routes.dart';

// Function to convert from home Product to search Product
search.Product convertToSearchProduct(Product homeProduct) {
  return search.Product(
    id: homeProduct.id,
    sku: homeProduct.sku,
    title: homeProduct.title,
    description: homeProduct.description,
    menuItems: [], // Required field
    subMenuItems: [], // Required field
    productType: homeProduct.productType ?? '',
    images: homeProduct.images,
    categories: [], // Convert as needed
    subCategories: [], // Convert as needed
    expressDelivery: homeProduct.expressDelivery,
    createdAt: homeProduct.createdAt,
    updatedAt: homeProduct.updatedAt,
    version: homeProduct.version,
    points: homeProduct.points,
    brand: null, // Convert if needed
    bundleTypes: [], // Convert if needed
    careTips: homeProduct.careTips,
    colors: [], // Convert if needed
    freeDelivery: homeProduct.freeDelivery ?? false,
    isBundle: homeProduct.isBundle ?? false,
    occasions: [], // Convert if needed
    premiumFlowers: homeProduct.premiumFlowers ?? false,
    productTypes: [], // Convert if needed
    recipients: [], // Convert if needed
    components: [], // Convert if needed
    price: search.Price(
      total: homeProduct.price.total.toDouble(),
      currency: homeProduct.price.currency,
    ),
    dimensions: homeProduct.dimensions != null
        ? search.Dimensions(
            width: homeProduct.dimensions!.width?.toDouble(),
            height: homeProduct.dimensions!.height?.toDouble(),
          )
        : null,
    bundleItems: [], // Convert if needed
  );
}

class GridProductsCard extends StatelessWidget {
  final List<SubCategory>? subCategories;
  final List<Product>? products;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final int crossAxisCount;
  final double spacing;
  final double runSpacing;

  const GridProductsCard({
    super.key,
    this.subCategories,
    this.products,
    this.buttonText,
    this.onButtonTap,
    this.crossAxisCount = 2,
    this.spacing = 20,
    this.runSpacing = 10,
  }) : assert(subCategories != null || products != null,
            'Either subCategories or products must be provided');

  @override
  Widget build(BuildContext context) {
    final items = subCategories ?? products ?? [];
    final isProducts = products != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // First row
        if (items.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (items.isNotEmpty)
                Expanded(
                  child: _buildProductBox(
                    context: context,
                    subCategory: !isProducts ? items[0] as SubCategory : null,
                    title: isProducts ? (items[0] as Product).title : null,
                    imageUrl: isProducts
                        ? (items[0] as Product).images.isNotEmpty
                            ? (items[0] as Product).images[0]
                            : ''
                        : null,
                    product: isProducts ? items[0] as Product : null,
                  ),
                ),
              SizedBox(width: spacing),
              if (items.length > 1)
                Expanded(
                  child: _buildProductBox(
                    context: context,
                    subCategory: !isProducts ? items[1] as SubCategory : null,
                    title: isProducts ? (items[1] as Product).title : null,
                    imageUrl: isProducts
                        ? (items[1] as Product).images.isNotEmpty
                            ? (items[1] as Product).images[0]
                            : ''
                        : null,
                    product: isProducts ? items[1] as Product : null,
                  ),
                ),
            ],
          ),

        const VerticalSpace(height: 10),

        // Second row
        if (items.length > 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (items.length > 2)
                Expanded(
                  child: _buildProductBox(
                    context: context,
                    subCategory: !isProducts ? items[2] as SubCategory : null,
                    title: isProducts ? (items[2] as Product).title : null,
                    imageUrl: isProducts
                        ? (items[2] as Product).images.isNotEmpty
                            ? (items[2] as Product).images[0]
                            : ''
                        : null,
                    product: isProducts ? items[2] as Product : null,
                  ),
                ),
              SizedBox(width: spacing),
              if (items.length > 3)
                Expanded(
                  child: _buildProductBox(
                    context: context,
                    subCategory: !isProducts ? items[3] as SubCategory : null,
                    title: isProducts ? (items[3] as Product).title : null,
                    imageUrl: isProducts
                        ? (items[3] as Product).images.isNotEmpty
                            ? (items[3] as Product).images[0]
                            : ''
                        : null,
                    product: isProducts ? items[3] as Product : null,
                  ),
                ),
              if (items.length <= 3) const Expanded(child: SizedBox()),
            ],
          ),

        if (buttonText != null && onButtonTap != null) ...[
          const VerticalSpace(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.offWhite,
                foregroundColor: ColorsManager.offWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: const BorderSide(
                    color: ColorsManager.darkGray,
                    width: 1.0,
                  ),
                ),
              ),
              onPressed: onButtonTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  buttonText!,
                  style: TextStylesInter.font14DarkGrayBold,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProductBox({
    SubCategory? subCategory,
    String? title,
    String? imageUrl,
    Product? product,
    required BuildContext context,
  }) {
    final displayTitle = subCategory?.name ?? title ?? '';
    final displayImageUrl = subCategory?.imageUrl ?? imageUrl ?? '';

    return InkWell(
      onTap: () {
        if (product != null) {
          // Convert home Product to search Product
          final searchProduct = convertToSearchProduct(product);
          context.pushNamed(
            Routes.productDetailsScreen,
            arguments: {'extraArgs': searchProduct},
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 170.h,
            width: double.infinity,
            child: Builder(
              builder: (context) {
                // Always show logo when URL is empty
                if (displayImageUrl.isEmpty) {
                  return Center(
                    child: SvgPicture.asset(
                      Assets.of(context).svgs.small_logo_svg,
                      height: 80.h,
                      width: 80.w,
                    ),
                  );
                }

                // Try to load the image with proper URL formatting
                final finalUrl = displayImageUrl.startsWith('http')
                    ? displayImageUrl
                    : HomeApiConstants.apiBaseUrlForImages + displayImageUrl;

                return CachedNetworkImage(
                  imageUrl: finalUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: SvgPicture.asset(
                      Assets.of(context).svgs.small_logo_svg,
                      height: 80.h,
                      width: 80.w,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: SvgPicture.asset(
                      Assets.of(context).svgs.small_logo_svg,
                      height: 80.h,
                      width: 80.w,
                    ),
                  ),
                );
              },
            ),
          ),
          const VerticalSpace(height: 10),
          if (product != null) ...[
            Text.rich(
              TextSpan(
                text: 'SAR ',
                style: TextStylesInter.font11MainRoseRegular,
                children: [
                  TextSpan(
                    text: '${product.price.total}',
                    style: TextStylesInter.font13MainRoseBold,
                  ),
                ],
              ),
            ),
            const VerticalSpace(height: 4),
          ],
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              displayTitle,
              style: TextStylesInter.font14BlackRegular
                  .copyWith(color: ColorsManager.mainRose),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const VerticalSpace(height: 15),
        ],
      ),
    );
  }
}
