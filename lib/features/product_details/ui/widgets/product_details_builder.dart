import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/cart/logic/addToCart/cubit/add_to_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/addToCart/cubit/add_to_cart_state.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_state.dart';
import 'package:wardaya/features/product_details/data/models/product_response.dart'
    as product_data_model;
import 'package:wardaya/features/product_details/logic/product_details/product_details_cubit.dart';
import 'package:wardaya/features/product_details/logic/product_details/product_details_state.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

import 'product_details_app_bar.dart';
import 'product_details_body.dart';

class ProductDetailsBuilder extends StatefulWidget {
  final Product product;

  const ProductDetailsBuilder({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsBuilder> createState() => _ProductDetailsBuilderState();
}

class _ProductDetailsBuilderState extends State<ProductDetailsBuilder> {
  @override
  void initState() {
    super.initState();
    // Fetch product details when the builder initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailsCubit>().getProductById(widget.product.id);
    });
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingWidget(loadingState: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        state.maybeMap(
          addFavoriteSuccess: (successState) {
            // If we get a message about product already in favorites,
            // we should treat it as a success and show the filled icon
            if (successState.response.message
                    ?.toLowerCase()
                    .contains('already in favorites') ??
                false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Product is already in favorites',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: ColorsManager.mainRose,
                  duration: Duration(seconds: 1),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Added to favorites',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
          deleteFavoriteSuccess: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Removed from favorites',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 1),
              ),
            );
          },
          error: (errorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorState.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, favoritesState) {
        return BlocConsumer<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            state.maybeMap(
              loading: (_) {
                _showLoadingDialog();
              },
              loaded: (loadedState) {
                Navigator.of(context).pop(); // Dismiss loading dialog
                context
                    .read<CartCubit>()
                    .changeLength(context.read<CartCubit>().cartItems + 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Product added to cart successfully',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              error: (errorState) {
                Navigator.of(context).pop(); // Dismiss loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      errorState.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, addToCartState) {
            return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: ProductDetailsAppBar(product: widget.product),
                  body: state.maybeWhen(
                    success: (product) {
                      return ProductDetailsBody(
                        product: product,
                        onAddToCart: () {
                          context.read<AddToCartCubit>().addToCart(
                            product.id,
                            1, // Default quantity
                            [], // Empty bundle items
                          );
                        },
                      );
                    },
                    loading: () => _buildLoading(),
                    error: (error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: ColorsManager.mainRose,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              error,
                              style: const TextStyle(
                                color: ColorsManager.darkGray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                // Retry loading product details
                                context
                                    .read<ProductDetailsCubit>()
                                    .getProductById(widget.product.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.mainRose,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    },
                    orElse: () => const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildLoading() {
    return Skeletonizer(
      enabled: true,
      child: ProductDetailsBody(
        product: product_data_model.ProductResponse(
          id: widget.product.id,
          sku: widget.product.sku,
          title: widget.product.title,
          description: widget.product.description,
          isBundle: widget.product.isBundle,
          price: product_data_model.Price(
            total: widget.product.price.total.toInt(),
            currency: widget.product.price.currency,
          ),
          images: widget.product.images,
          categories: widget.product.categories,
          subCategories: widget.product.subCategories,
          menuItems: widget.product.menuItems,
          subMenuItems: widget.product.subMenuItems,
          productTypes: widget.product.productTypes,
          occasions: widget.product.occasions,
          brand: widget.product.brand,
          expressDelivery: widget.product.expressDelivery,
          points: widget.product.points ?? 0,
          components: widget.product.components,
          dimensions: widget.product.dimensions != null
              ? product_data_model.Dimensions(
                  width: widget.product.dimensions!.width?.toInt(),
                  height: widget.product.dimensions!.height?.toInt(),
                )
              : null,
          bundleItems: widget.product.bundleItems
              .map((item) => product_data_model.BundleItemResponse(
                    id: item.id,
                    categories: [
                      product_data_model.BundleCategoryItem(
                        id: '0',
                        categoryTitle: 'Bundle Item',
                        categoryTitleAr: null,
                        items: [],
                        isRequired: false,
                      )
                    ],
                  ))
              .toList(),
          colors: widget.product.colors,
          recipients: widget.product.recipients,
          bundleTypes: widget.product.bundleTypes,
          careTips: widget.product.careTips ?? '',
          freeDelivery: widget.product.freeDelivery,
          premiumFlowers: widget.product.premiumFlowers,
          createdAt: widget.product.createdAt.toIso8601String(),
          updatedAt: widget.product.updatedAt.toIso8601String(),
          version: widget.product.version,
        ),
        onAddToCart: () {},
      ),
    );
  }
}
