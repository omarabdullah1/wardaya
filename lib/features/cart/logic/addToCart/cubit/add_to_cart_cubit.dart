import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:wardaya/features/cart/data/models/add_cart_response.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';

import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final CartRepo _cartRepo;
  AddToCartCubit(this._cartRepo) : super(const AddToCartState.initial());

  void addToCart(
    String productId,
    int quantity,
    List<String> bundleItems,
  ) async {
    emit(const AddToCartState.loading());
    try {
      final response = await _cartRepo.addToCart({
        'productId': productId,
        'quantity': quantity,
        'bundleItems': bundleItems,
      });
      response.when(
        success: (AddCartResponse data) {
          log('data: $data');
          log('Successfully received Cart data with ${data.cart.length} items');
          emit(AddToCartState.loaded(data));
        },
        failure: (error) {
          log('Error fetching Cart data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(AddToCartState.error(
              error.message ?? 'Failed to fetch Cart data'));
        },
      );
    } catch (e, stackTrace) {
      log('Cart unexpected error: $e', stackTrace: stackTrace);
      emit(AddToCartState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
