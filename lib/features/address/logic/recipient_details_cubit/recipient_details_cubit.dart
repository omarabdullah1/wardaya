import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'recipient_details_state.dart';

class RecipientDetailsCubit extends Cubit<RecipientDetailsState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController extraAddressController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  // Location data
  LatLng? selectedLocation;

  RecipientDetailsCubit() : super(const RecipientDetailsState.initial());

  // Update location data from map picker
  void updateLocationData(LatLng location, String address, String area) {
    selectedLocation = location;
    addressController.text = address;
    areaController.text = area;

    // Emit new state with updated location data
    emit(RecipientDetailsState.locationUpdated(
      location: location,
      address: address,
      area: area,
    ));
  }

  // Pre-populate form if editing an existing address
  void initializeWithAddress(String? recipientName, String? phoneNumber,
      String? area, String? address, String? extraDetails, LatLng? location) {
    nameController.text = recipientName ?? '';
    phoneController.text = phoneNumber ?? '';
    areaController.text = area ?? '';
    addressController.text = address ?? '';
    extraAddressController.text = extraDetails ?? '';
    selectedLocation = location;

    // Emit initialized state
    emit(RecipientDetailsState.initialized(
      recipientName: recipientName ?? '',
      phoneNumber: phoneNumber ?? '',
      area: area ?? '',
      address: address ?? '',
      extraDetails: extraDetails ?? '',
      location: location,
    ));
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    searchController.dispose();
    areaController.dispose();
    return super.close();
  }
}
