import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/get_gift_cards_response.dart';

part 'gift_cards_state.freezed.dart';

@freezed
class GiftCardsState with _$GiftCardsState {
  const factory GiftCardsState.initial() = _Initial;
  const factory GiftCardsState.loading() = Loading;
  const factory GiftCardsState.loaded(List<GiftCardTemplate> giftCards) =
      Loaded;
  const factory GiftCardsState.error(String message) = Error;
}
