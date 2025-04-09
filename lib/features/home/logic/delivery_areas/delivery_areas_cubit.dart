import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/home_delivery_areas_response.dart';
import '../../data/repos/home_repo.dart';
import 'delivery_areas_state.dart';

class DeliveryAreasCubit extends Cubit<DeliveryAreasState> {
  final HomeRepo _homeRepo;
  List<DeliveryArea> _cachedDeliveryAreas = [];

  DeliveryAreasCubit(this._homeRepo)
      : super(const DeliveryAreasState.initial());

  List<DeliveryArea> get deliveryAreas => _cachedDeliveryAreas;

  Future<void> getDeliveryAreas() async {
    emit(const DeliveryAreasState.loading());
    try {
      log('Fetching delivery areas from API...');
      final response = await _homeRepo.getHomeDeliveryAreas();
      response.when(
        success: (List<DeliveryArea> data) {
          _cachedDeliveryAreas = data;
          log('Successfully received Delivery Areas data with ${data.length} items');

          // Log detailed information about each area and city
          for (var area in data) {
            log('Area: ${area.country} (${area.cities.length} cities)');
            for (var city in area.cities) {
              log('  - ${city.name}: Delivery Price ${city.deliveryPrice} ${city.currency ?? area.currency}');
            }
          }

          emit(DeliveryAreasState.success(data));
        },
        failure: (error) {
          log('Error fetching Delivery Areas data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(DeliveryAreasState.error(
              error.message ?? 'Failed to fetch Delivery Areas data'));
        },
      );
    } catch (e, stackTrace) {
      log('Delivery Areas unexpected error: $e', stackTrace: stackTrace);
      emit(DeliveryAreasState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Get a specific city by ID
  City? getCityById(String cityId) {
    for (var area in _cachedDeliveryAreas) {
      for (var city in area.cities) {
        if (city.id == cityId) {
          return city;
        }
      }
    }
    return null;
  }
}
