import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/cart/data/models/get_gift_cards_response.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';
import 'gift_cards_state.dart';

class GiftCardsCubit extends Cubit<GiftCardsState> {
  final CartRepo _cartRepo;

  GiftCardsCubit(this._cartRepo) : super(const GiftCardsState.initial());

  Future<void> getGiftCards() async {
    if (isClosed) return;

    emit(const GiftCardsState.loading());
    try {
      final response = await _cartRepo.getGiftCards();

      if (isClosed) return;

      response.when(
        success: (List<GiftCardTemplate> data) {
          log('Successfully received gift cards data with ${data.length} items');
          emit(GiftCardsState.loaded(data));
        },
        failure: (error) {
          log('Error fetching gift cards data: ${error.message}');
          emit(GiftCardsState.error(
              error.message ?? 'Failed to fetch Gift cards data'));
        },
      );
    } catch (e, stackTrace) {
      log('Gift cards unexpected error: $e', stackTrace: stackTrace);
      emit(GiftCardsState.error(e.toString()));
    }
  }
}
