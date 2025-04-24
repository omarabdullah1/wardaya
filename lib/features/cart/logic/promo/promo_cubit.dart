import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/cart_repo.dart';
import 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  final CartRepo _cartRepo;

  // Store validated promo data
  String? _promoCode;
  String? _promoId;
  double? _discountPercentage;

  // Getters for validated promo data
  String? get promoCode => _promoCode;
  String? get promoId => _promoId;
  double? get discountPercentage => _discountPercentage;
  final TextEditingController promoCodeController = TextEditingController();

  PromoCubit(this._cartRepo) : super(const PromoState.initial());

  /// Validate a promo code by sending it to the API
  Future<void> validatePromoCode(String code) async {
    if (code.isEmpty) {
      emit(const PromoState.error('Promo code cannot be empty'));
      return;
    }

    emit(const PromoState.loading());

    try {
      final result = await _cartRepo.validatePromo(code);

      result.when(
        success: (data) {
          _promoCode = code;
          _promoId = data.promoCodeId;
          _discountPercentage = data.discountPercentage;

          log('Promo code validated: $_promoCode');
          log('Promo ID: $_promoId');
          log('Discount percentage: $_discountPercentage');

          emit(PromoState.success(data));
        },
        failure: (error) {
          _clearPromoData();

          final message = error.message ?? 'Invalid promo code';
          log('Error validating promo code: $message');
          emit(PromoState.error(message));
        },
      );
    } catch (e) {
      _clearPromoData();

      log('Exception validating promo code: $e');
      emit(const PromoState.error('An unexpected error occurred'));
    }
  }

  /// Clear a previously applied promo code
  void clearPromoCode() {
    _clearPromoData();
    emit(const PromoState.initial());
  }

  /// Reset promo data when validation fails or when clearing
  void _clearPromoData() {
    _promoCode = null;
    _promoId = null;
    _discountPercentage = null;
  }

  /// Calculate discounted price based on the current promo code
  double calculateDiscountedPrice(double originalPrice) {
    if (_discountPercentage == null || _discountPercentage == 0) {
      return originalPrice;
    }

    final discount = originalPrice * (_discountPercentage! / 100);
    return originalPrice - discount;
  }
}
