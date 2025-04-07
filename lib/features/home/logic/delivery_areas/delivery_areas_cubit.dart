import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/home_delivery_areas_response.dart';
import '../../data/repos/home_repo.dart';
import 'delivery_areas_state.dart';

class DeliveryAreasCubit extends Cubit<DeliveryAreasState> {
  final HomeRepo _homeRepo;
  DeliveryAreasCubit(this._homeRepo)
      : super(const DeliveryAreasState.initial());

  Future<void> getDeliveryAreas() async {
    emit(const DeliveryAreasState.loading());
    try {
      final response = await _homeRepo.getHomeDeliveryAreas();
      response.when(
        success: (List<DeliveryArea> data) {
          log('Successfully received Delivery Areas data with ${data.length} items');
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
}
