import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/promo_code_response.dart';

part 'promo_state.freezed.dart';

@freezed
class PromoState with _$PromoState {
  const factory PromoState.initial() = _Initial;
  const factory PromoState.loading() = Loading;
  const factory PromoState.success(PromoCodeResponse promoResponse) = Success;
  const factory PromoState.error(String message) = Error;
}
