import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/product_details/data/repos/product_details_repo.dart';

import '../../../search/logic/cubit/search_cubit.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo _productDetailsRepo;

  ProductDetailsCubit(this._productDetailsRepo)
      : super(const ProductDetailsState.initial());

  // Fetch product details
  void getProductById(String productId, BuildContext context) async {
    emit(const ProductDetailsState.loading());
    try {
      final response = await _productDetailsRepo.getProductById(productId);
      response.when(
        success: (product) {
          log('Successfully received product data for ID: $productId');
          emit(ProductDetailsState.success(product));
          _emitSearchStates(product, context);
        },
        failure: (error) {
          log('Error fetching product data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(ProductDetailsState.error(
              error.message ?? 'Failed to fetch product details'));
        },
      );
    } catch (e, stackTrace) {
      log('Product details unexpected error: $e', stackTrace: stackTrace);
      emit(ProductDetailsState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }

  void _emitSearchStates(dynamic product, BuildContext context) {
    try {
      // final firstOccasion =
      //     product.occasions is List && product.occasions.isNotEmpty
      //         ? (product.occasions.first is Map
      //             ? product.occasions.first['_id']
      //             : null)
      //         : null;

      final firstCategory =
          product.categories is List && product.categories.isNotEmpty
              ? (product.categories.first is Map
                  ? product.categories.first['_id']
                  : null)
              : null;

      final firstSubCategory =
          product.subCategories is List && product.subCategories.isNotEmpty
              ? (product.subCategories.first is Map
                  ? product.subCategories.first['_id']
                  : null)
              : null;

      context.read<SearchCubit>().emitSearchStates(
            expressDelivery: product.expressDelivery ?? false,
            // filterBrand: brandId,
            // filterOccasion: firstOccasion,
            filterCategory: firstCategory,
            // filterSubCategory: firstSubCategory,
            // filterColor: firstColor,
            // filterRecipients: firstRecipient,
          );
    } catch (e) {
      log('Error in _emitSearchStates: $e');
    }
  }

  // void getRelatedProducts(String productId) async {
  //   try {
  //     final response = await _productDetailsRepo.getRelatedProducts(productId);
  //     response.when(
  //       success: (products) {
  //         log('Successfully received related products data with ${products.length} items');
  //         emit(ProductDetailsState.relatedProductsSuccess(products));
  //       },
  //       failure: (error) {
  //         log('Error fetching related products: ${error.message}, Details: ${error.message} - and error ${error.error}');
  //         emit(ProductDetailsState.error(
  //             error.message ?? 'Failed to fetch related products'));
  //       },
  //     );
  //   } catch (e, stackTrace) {
  //     log('Related products unexpected error: $e', stackTrace: stackTrace);
  //     emit(ProductDetailsState.error('An unexpected error occurred: ${e.toString()}'));
  //   }
  // }
}
