import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/menu_items_response.dart';

part 'explore_state.freezed.dart';

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loading() = Loading;
  const factory ExploreState.success(MenuItemsResponse menuItemsResponse) =
      Success;
  const factory ExploreState.failure(String message) = Failure;
}
