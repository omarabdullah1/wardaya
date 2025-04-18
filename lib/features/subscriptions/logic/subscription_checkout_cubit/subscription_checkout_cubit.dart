import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/features/subscriptions/data/models/subscription_checkout_request.dart';
import 'package:wardaya/features/subscriptions/data/repos/subscription_repo.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import './subscription_checkout_state.dart';

class SubscriptionCheckoutCubit extends Cubit<SubscriptionCheckoutState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Location data
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  String _selectedArea = '';
  String _additionalInfo = '';

  final SubscriptionRepo _subscriptionRepo;
  SubscriptionCheckoutCubit(this._subscriptionRepo)
      : super(const SubscriptionCheckoutState.initial());

  // Getters for location data
  LatLng? get selectedLocation => _selectedLocation;
  String get selectedAddress => _selectedAddress;
  String get selectedArea => _selectedArea;
  String get additionalInfo => _additionalInfo;

  // Update location data from map picker
  void updateLocationData(
      LatLng location, String address, String area, String additionalInfo) {
    _selectedLocation = location;
    _selectedAddress = address;
    _selectedArea = area;
    _additionalInfo = additionalInfo;

    emit(SubscriptionCheckoutState.locationSelected(
      location: location,
      address: address,
      area: area,
      additionalInfo: additionalInfo,
    ));

    log('Location updated in cubit:');
    log('Location: ${location.latitude}, ${location.longitude}');
    log('Address: $address');
    log('Area: $area');
    log('Additional Info: $additionalInfo');
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

  String _formatDateForApi(String dateStr) {
    // Parse the start date, removing the day name if present
    final parts = dateStr.split(', ');
    final datePart = parts.length > 1 ? parts[1] : parts[0];
    final dateParts = datePart.split('/');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }

  Future<void> checkout({
    required String plan,
    required String deliveryFrequency,
    required String duration,
    required String startDate,
    required String amount,
    required String currency,
    required String description,
    required String sourceId,
    required String name,
    required String code,
    required String phone,
    required LatLng location,
    required String address,
    required String area,
    required bool keepIdentitySecret,
    required String additionalInfo,
  }) async {
    final String? cityId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userAreaId);
    log(cityId!);
    emit(const SubscriptionCheckoutState.loading());
    try {
      final formattedStartDate = _formatDateForApi(startDate);

      final response = await _subscriptionRepo.checkout(
        SubscriptionCheckoutRequest(
          subscriptionPlan: plan,
          deliveryFrequency: deliveryFrequency,
          duration: duration,
          startDate: formattedStartDate,
          amount: double.parse(amount),
          currency: currency,
          description: description,
          deliveryAreaCity: cityId,
          redirectUrl: 'https://www.wardaya.net/cart',
          sourceId: SourceId(
            id: sourceId,
            phone: null,
          ),
          deliveryInfo: DeliveryInfo(
            name: name,
            phone: phone,
            countryCode: code,
            keepIdentitySecret: keepIdentitySecret,
            shipping: !keepIdentitySecret
                ? Shipping(
                    recipientArea: area,
                    recipientAddress: address,
                    extraAddressDetails: additionalInfo,
                    latitude: location.latitude,
                    longitude: location.longitude,
                  )
                : null,
          ),
          transactionRef: 'mob_txn_01',
        ),
      );
      response.when(success: (data) {
        log('Subscription checkout completed successfully');
        emit(SubscriptionCheckoutState.loaded(data));
      }, failure: (error) {
        log('Error in subscription checkout: ${error.message}');
        emit(SubscriptionCheckoutState.error(
            message: error.message ?? 'Unknown error occurred'));
      });
    } catch (e) {
      if (isClosed) return;

      log('Exception in subscription checkout: $e');
      emit(const SubscriptionCheckoutState.error(
          message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
