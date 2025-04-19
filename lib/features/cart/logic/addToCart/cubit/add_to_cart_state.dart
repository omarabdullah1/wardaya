import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/cart/data/models/add_cart_response.dart';
part 'add_to_cart_state.freezed.dart';

@freezed
class AddToCartState with _$AddToCartState {
  const factory AddToCartState.initial() = _Initial;
  const factory AddToCartState.loading() = Loading;
  const factory AddToCartState.loaded(AddCartResponse response) = Loaded;
  const factory AddToCartState.error(String message) = Error;
}
