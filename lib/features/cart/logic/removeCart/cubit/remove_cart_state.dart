import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/cart/data/models/remove_cart_response.dart';

part 'remove_cart_state.freezed.dart';

@freezed
class RemoveCartState with _$RemoveCartState {
  const factory RemoveCartState.initial() = _Initial;
  const factory RemoveCartState.loading() = Loading;
  const factory RemoveCartState.loaded(RemoveCartResponse response) = Loaded;
  const factory RemoveCartState.error(String message) = Error;
}