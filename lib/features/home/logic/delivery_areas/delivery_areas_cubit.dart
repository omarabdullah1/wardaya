import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
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
        success: (List<DeliveryArea> data) async {
          _cachedDeliveryAreas = _sortDeliveryAreas(data);
          log('Successfully received Delivery Areas data with ${data.length} items');

          // Load saved city ID
          final savedCityId = await SharedPrefHelper.getSecuredString(
              SharedPrefKeys.userAreaId);
          log('Retrieved saved city ID: $savedCityId');

          if (savedCityId != null && savedCityId.isNotEmpty) {
            final city = getCityById(savedCityId);
            if (city != null) {
              log('Successfully restored saved city: ${city.name}');
            }
          }

          emit(DeliveryAreasState.success(_cachedDeliveryAreas));
        },
        failure: (error) {
          log('Error fetching Delivery Areas data: ${error.message}');
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

  List<DeliveryArea> _sortDeliveryAreas(List<DeliveryArea> areas) {
    final sorted = List<DeliveryArea>.from(areas);
    sorted.sort((a, b) {
      if (a.country == 'Saudi Arabia') return -1;
      if (b.country == 'Saudi Arabia') return 1;
      return a.country.compareTo(b.country);
    });
    return sorted;
  }

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

  Future<void> updateSelectedCity(String cityId) async {
    try {
      log('DeliveryAreas: City updated to: $cityId');
      final city = getCityById(cityId);
      if (city == null) {
        emit(const DeliveryAreasState.error('City not found'));
        return;
      }

      final response = await _homeRepo.updateUserCity(cityId);
      response.when(
        success: (data) async {
          log('Successfully updated user city: ${data.message}');
          // Save the selected city ID to local storage
          await SharedPrefHelper.setSecuredString(
              SharedPrefKeys.userAreaId, cityId);
          emit(DeliveryAreasState.updateCity(data));

          // Refresh delivery areas to ensure we have the latest data
          await getDeliveryAreas();
        },
        failure: (error) {
          log('Error updating user city: ${error.message}');
          emit(DeliveryAreasState.error(
              error.message ?? 'Failed to update user city'));
        },
      );
    } catch (e, stackTrace) {
      log('Unexpected error updating user city: $e', stackTrace: stackTrace);
      emit(DeliveryAreasState.error(
          'An unexpected error occurred while updating city: ${e.toString()}'));
    }
  }
}
