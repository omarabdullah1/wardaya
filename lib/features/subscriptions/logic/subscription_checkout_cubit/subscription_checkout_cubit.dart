import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './subscription_checkout_state.dart';

class SubscriptionCheckoutCubit extends Cubit<SubscriptionCheckoutState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Location data
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  String _selectedArea = '';

  SubscriptionCheckoutCubit()
      : super(const SubscriptionCheckoutState.initial());

  // Getters for location data
  LatLng? get selectedLocation => _selectedLocation;
  String get selectedAddress => _selectedAddress;
  String get selectedArea => _selectedArea;

  // Update location data from map picker
  void updateLocationData(LatLng location, String address, String area) {
    _selectedLocation = location;
    _selectedAddress = address;
    _selectedArea = area;

    emit(SubscriptionCheckoutState.locationSelected(
      location: location,
      address: address,
      area: area,
    ));

    log('Location updated in cubit:');
    log('Location: ${location.latitude}, ${location.longitude}');
    log('Address: $address');
    log('Area: $area');
  }

  Future<void> pickContact() async {
    final hasPermission = await FlutterContacts.requestPermission();
    if (!hasPermission) {
      return;
    }

    try {
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        final fullContact = await FlutterContacts.getContact(contact.id);
        if (fullContact != null) {
          nameController.text = fullContact.displayName;
          if (fullContact.phones.isNotEmpty) {
            final phone = fullContact.phones.first.number;
            phoneController.text = phone.replaceAll(RegExp(r'[^\d]'), '');
          }

          emit(SubscriptionCheckoutState.recipientSelected(
            recipientName: fullContact.displayName,
            phoneNumber: phoneController.text,
          ));
        }
      }
    } catch (e) {
      log('Error picking contact: $e');
      emit(const SubscriptionCheckoutState.error(
        message: 'Failed to pick contact',
      ));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
