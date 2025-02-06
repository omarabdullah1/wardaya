import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  int cartItems = 1;
  CartCubit() : super(const CartState.initial());

  void changeLength(int newLength) async {
    cartItems = newLength;
    emit(CartState.changeLength(cartItems));
  }
}
