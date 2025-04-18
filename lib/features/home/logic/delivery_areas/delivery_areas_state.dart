import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wardaya/features/home/data/models/home_update_city_response.dart';

import '../../data/models/home_delivery_areas_response.dart';

part 'delivery_areas_state.freezed.dart';

@freezed
class DeliveryAreasState with _$DeliveryAreasState {
  const factory DeliveryAreasState.initial() = _Initial;
  const factory DeliveryAreasState.loading() = Loading;
  const factory DeliveryAreasState.success(List<DeliveryArea> deliveryAreas) =
      Success;
  const factory DeliveryAreasState.updateCity(
      HomeUpdateCityResponse homeUpdateCityResponse) = UpdateCity;
  const factory DeliveryAreasState.error(String message) = Error;
}
