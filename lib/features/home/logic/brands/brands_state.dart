import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/home/data/models/home_brands_response.dart';

part 'brands_state.freezed.dart';

@freezed
class BrandsState with _$BrandsState {
  const factory BrandsState.initial() = _Initial;
  const factory BrandsState.loading() = _Loading;
  const factory BrandsState.success(HomeBrandsResponse response) = _Success;
  const factory BrandsState.error(String message) = _Error;
}
