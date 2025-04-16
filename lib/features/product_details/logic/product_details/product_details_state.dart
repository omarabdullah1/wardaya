import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/product_response.dart';

part 'product_details_state.freezed.dart';

@freezed
class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = Loading;
  const factory ProductDetailsState.success(ProductResponse product) = Success;
  const factory ProductDetailsState.relatedProductsSuccess(
      List<ProductResponse> products) = RelatedProductsSuccess;
  const factory ProductDetailsState.error(String message) = Error;
}
