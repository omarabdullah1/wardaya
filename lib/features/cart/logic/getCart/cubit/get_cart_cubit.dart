import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:wardaya/features/cart/data/models/get_cart_response.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';

import 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  final CartRepo _cartRepo;
  GetCartCubit(this._cartRepo) : super(const GetCartState.initial());
  int cartItems = 0;
  void getCart() async {
    emit(const GetCartState.loading());
    try {
      final response = await _cartRepo.getCart();
      response.when(
        success: (List<GetCartItem> data) {
          log('data: $data');
          log('Successfully received Cart data with ${data.length} items');
          cartItems = data.length;
          emit(GetCartState.loaded(data));
        },
        failure: (error) {
          log('Error fetching Cart data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(
              GetCartState.error(error.message ?? 'Failed to fetch Cart data'));
        },
      );
    } catch (e, stackTrace) {
      log('Cart unexpected error: $e', stackTrace: stackTrace);
      emit(GetCartState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
