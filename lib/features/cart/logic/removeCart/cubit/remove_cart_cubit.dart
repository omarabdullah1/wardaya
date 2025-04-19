import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:wardaya/features/cart/data/models/remove_cart_response.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';

import 'remove_cart_state.dart';

class RemoveCartCubit extends Cubit<RemoveCartState> {
  final CartRepo _cartRepo;
  
  RemoveCartCubit(this._cartRepo) : super(const RemoveCartState.initial());

  void removeFromCart(String productId) async {
    emit(const RemoveCartState.loading());
    try {
      final response = await _cartRepo.removeFromCart(productId);
      response.when(
        success: (RemoveCartResponse data) {
          log('Successfully removed item from cart');
          emit(RemoveCartState.loaded(data));
        },
        failure: (error) {
          log('Error removing item from cart: ${error.message}');
          emit(RemoveCartState.error(
              error.message ?? 'Failed to remove item from cart'));
        },
      );
    } catch (e, stackTrace) {
      log('Cart remove unexpected error: $e', stackTrace: stackTrace);
      emit(RemoveCartState.error(
          'An unexpected error occurred while removing item: ${e.toString()}'));
    }
  }
}