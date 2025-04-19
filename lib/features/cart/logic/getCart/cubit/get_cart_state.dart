import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/get_cart_response.dart';
part 'get_cart_state.freezed.dart';

@freezed
class GetCartState with _$GetCartState {
  const factory GetCartState.initial() = _Initial;
  const factory GetCartState.loading() = Loading;
  const factory GetCartState.loaded(List<GetCartItem> cartItems) = Loaded;
  const factory GetCartState.error(String message) = Error;
}
