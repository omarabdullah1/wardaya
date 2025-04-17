import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';

part 'my_orders_state.freezed.dart';

@freezed
class MyOrdersState with _$MyOrdersState {
  const factory MyOrdersState.initial() = Initial;
  const factory MyOrdersState.loading() = Loading;
  const factory MyOrdersState.success(MyOrdersResponse orders) = Success;
  const factory MyOrdersState.error(String message) = Error;
}
