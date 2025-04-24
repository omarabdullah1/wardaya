import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/models/address_request.dart';
import '../../data/repos/address_repo.dart';
import 'recipient_details_state.dart';

class RecipientDetailsCubit extends Cubit<RecipientDetailsState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController extraAddressController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController titleController =
      TextEditingController(); // For address title

  // Dependencies
  final AddressRepo addressRepo;

  // Location data
  LatLng? selectedLocation;
  String? selectedCityId; // To store the city ID
  String selectedCountryCode = '+966'; // Default country code

  // Store the address ID when editing an existing address
  String? addressId;

  RecipientDetailsCubit(this.addressRepo)
      : super(const RecipientDetailsState.initial());

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
  void initializeWithAddress(
      {String? recipientName,
      String? phoneNumber,
      String? area,
      String? address,
      String? extraDetails,
      LatLng? location,
      String? id}) {
    nameController.text = recipientName ?? '';
    phoneController.text = phoneNumber ?? '';
    areaController.text = area ?? '';
    addressController.text = address ?? '';
    extraAddressController.text = extraDetails ?? '';
    selectedLocation = location;
    addressId = id; // Store the address ID for editing

    // Set a default title based on the area if available
    if (area != null && area.isNotEmpty) {
      titleController.text = 'My Address in $area';
    } else {
      titleController.text = 'My Address';
    }

    // Emit initialized state
    emit(RecipientDetailsState.initialized(
      recipientName: recipientName ?? '',
      phoneNumber: phoneNumber ?? '',
      area: area ?? '',
      address: address ?? '',
      extraDetails: extraDetails ?? '',
      location: location,
      id: id,
    ));
  }

  // Set the selected city ID
  Future<void> setSelectedCityId() async {
    selectedCityId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userAreaId);
  }

  // Set the selected country code
  void setCountryCode(String countryCode) {
    selectedCountryCode = countryCode;
    emit(RecipientDetailsState.countryCodeUpdated(countryCode: countryCode));
  }

  // Create new address
  Future<void> createAddress() async {
    // Validate required fields
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedLocation == null ||
        selectedCityId == null) {
      emit(const RecipientDetailsState.error(
        error: 'Please fill all required fields',
      ));
      return;
    }

    emit(const RecipientDetailsState.loading());

    final addressRequest = AddressRequest(
      recipientCity: (await SharedPrefHelper.getSecuredString(
              SharedPrefKeys.userAreaId)) ??
          '',
      title: null,
      userId: await SharedPrefHelper.getSecuredString(SharedPrefKeys.userID),
      recipientArea: areaController.text,
      recipientName: nameController.text,
      recipientCountryCode: selectedCountryCode, // Use selected country code
      recipientPhoneNumber: phoneController.text,
      recipientAddress: addressController.text,
      extraAddressDetails: extraAddressController.text,
      latitude: selectedLocation!.latitude.toString(),
      longitude: selectedLocation!.longitude.toString(),
    );
    log(addressRequest.toString());
    try {
      final result = await addressRepo.createAddress(addressRequest);
      result.when(
        success: (address) {
          emit(RecipientDetailsState.success(address: address));
        },
        failure: (error) {
          emit(RecipientDetailsState.error(
            error: error.message ?? 'Failed to create address',
          ));
        },
      );
    } catch (e) {
      emit(RecipientDetailsState.error(
        error: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  // Update existing address
  Future<void> updateAddress() async {
    // Validate required fields
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedLocation == null ||
        selectedCityId == null ||
        addressId == null) {
      emit(const RecipientDetailsState.error(
        error: 'Please fill all required fields',
      ));
      return;
    }

    emit(const RecipientDetailsState.loading());

    final addressRequest = AddressRequest(
      recipientCity: (await SharedPrefHelper.getSecuredString(
              SharedPrefKeys.userAreaId)) ??
          '',
      title: titleController.text.isEmpty ? null : titleController.text,
      userId: await SharedPrefHelper.getSecuredString(SharedPrefKeys.userID),
      recipientArea: areaController.text,
      recipientName: nameController.text,
      recipientCountryCode: selectedCountryCode,
      recipientPhoneNumber: phoneController.text,
      recipientAddress: addressController.text,
      extraAddressDetails: extraAddressController.text,
      latitude: selectedLocation!.latitude.toString(),
      longitude: selectedLocation!.longitude.toString(),
    );

    log('Updating address: $addressId with data: ${addressRequest.toString()}');

    try {
      final result =
          await addressRepo.updateAddress(addressId!, addressRequest);
      result.when(
        success: (address) {
          emit(RecipientDetailsState.success(address: address));
        },
        failure: (error) {
          emit(RecipientDetailsState.error(
            error: error.message ?? 'Failed to update address',
          ));
        },
      );
    } catch (e) {
      emit(RecipientDetailsState.error(
        error: 'An unexpected error occurred: ${e.toString()}',
      ));
    }
  }

  // Helper method to save address (either create or update based on addressId)
  Future<void> saveAddress() async {
    if (addressId != null) {
      await updateAddress();
    } else {
      await createAddress();
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    extraAddressController.dispose();
    searchController.dispose();
    areaController.dispose();
    titleController.dispose();
    return super.close();
  }
}
