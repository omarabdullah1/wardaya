import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/product_details/data/repos/product_details_repo.dart';

import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo _productDetailsRepo;

  ProductDetailsCubit(this._productDetailsRepo)
      : super(const ProductDetailsState.initial());

  // Fetch product details
  void getProductById(String productId) async {
    emit(const ProductDetailsState.loading());
    try {
      final response = await _productDetailsRepo.getProductById(productId);
      response.when(
        success: (product) {
          log('Successfully received product data for ID: $productId');
          emit(ProductDetailsState.success(product));
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
