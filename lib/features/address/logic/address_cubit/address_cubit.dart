import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/address_response.dart';
import '../../data/repos/address_repo.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepo _addressRepo;
  bool _isClosed = false;

  AddressCubit(this._addressRepo) : super(const AddressState.initial());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  Future<void> getAddresses() async {
    if (_isClosed) return;
    emit(const AddressState.loading());
    try {
      final response = await _addressRepo.getAddresses();
      if (_isClosed) return;

      response.when(
        success: (List<Address> data) {
          if (_isClosed) return;
          log('data: $data');
          log('Successfully received Addresses data with ${data.length} items');
          emit(AddressState.success(addresses: data));
        },
        failure: (error) {
          if (_isClosed) return;
          log('Error fetching Addresses data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(AddressState.error(
              error: error.message ?? 'Failed to fetch Addresses data'));
        },
      );
    } catch (e, stackTrace) {
      if (_isClosed) return;
      log('Addresses unexpected error: $e', stackTrace: stackTrace);
      emit(AddressState.error(
          error: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
