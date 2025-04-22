import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/features/cart/data/models/checkout_request.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../data/repos/cart_repo.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Location data
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  String _selectedArea = '';
  String _additionalInfo = '';

  // Delivery date and time
  String _selectedDeliveryDate = '';
  // String _selectedDeliveryTime = '';

  final CartRepo _cartRepo;
  CheckoutCubit(this._cartRepo) : super(const CheckoutState.initial());

  // Getters for location data
  LatLng? get selectedLocation => _selectedLocation;
  String get selectedAddress => _selectedAddress;
  String get selectedArea => _selectedArea;
  String get additionalInfo => _additionalInfo;

  // Getters for delivery date and time
  String get selectedDeliveryDate => _selectedDeliveryDate;
  DateTime get selectedDate => state.maybeWhen(
        deliveryTimeSelected: (date, dateTime) => dateTime,
        orElse: () => DateTime.now(),
      );
  // String get selectedDeliveryTime => _selectedDeliveryTime;

  // Update delivery date and time
  void updateDeliveryDateTime(
    String date,
    DateTime dateTime,
    /*String time*/
  ) {
    _selectedDeliveryDate = date;
    // _selectedDeliveryTime = time;
    emit(CheckoutState.deliveryTimeSelected(
      date: date,
      dateTime: dateTime,
      // time: time,
    ));
    log('Delivery date and time updated in cubit:');
    log('Date: $date');
    // log('Time: $time');
  }

  // Update location data from map picker
  void updateLocationData(
      LatLng location, String address, String area, String additionalInfo) {
    _selectedLocation = location;
    _selectedAddress = address;
    _selectedArea = area;
    _additionalInfo = additionalInfo;

    emit(CheckoutState.locationSelected(
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
    log('Requesting contact permission');
    final hasPermission = await FlutterContacts.requestPermission();
    if (!hasPermission) {
      FlutterContacts.requestPermission();
    }
    log('Permission granted');
    try {
      log('Opening contact picker');
      final contact = await FlutterContacts.openExternalPick();
      log('Contact selected: $contact');
      if (contact != null) {
        final fullContact = await FlutterContacts.getContact(contact.id);
        if (fullContact != null) {
          nameController.text = fullContact.displayName;
          if (fullContact.phones.isNotEmpty) {
            final phone = fullContact.phones.first.number;
            phoneController.text = phone.replaceAll(RegExp(r'[^\d]'), '');
          }

          emit(CheckoutState.recipientSelected(
            recipientName: fullContact.displayName,
            phoneNumber: phoneController.text,
          ));
        }
      }
    } catch (e) {
      log('Error picking contact: $e');
      emit(const CheckoutState.error(
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
    String? promoCode,
    String? promoId,
    String? giftCardID,
    String? from,
    String? to,
    String? message,
    bool? isHandWritten,
    String? qrImageUrl,
    String? signatureImageUrl,
    String? link,
  }) async {
    emit(const CheckoutState.loading());

    try {
      final cityId = await _getCityId();
      final formattedStartDate = startDate; //_formatDateForApi(startDate);

      final checkoutRequest = _buildCheckoutRequest(
        startDate: formattedStartDate,
        amount: amount,
        currency: currency,
        description: description,
        sourceId: sourceId,
        name: name,
        code: code,
        phone: phone,
        location: location,
        address: address,
        area: area,
        keepIdentitySecret: keepIdentitySecret,
        additionalInfo: additionalInfo,
        promoCode: promoCode,
        promoId: promoId,
        giftCardID: giftCardID,
        from: from,
        to: to,
        message: message,
        isHandWritten: isHandWritten,
        qrImageUrl: qrImageUrl,
        signatureImageUrl: signatureImageUrl,
        link: link,
        cityId: cityId ?? '',
      );

      final response = await _cartRepo.checkout(checkoutRequest);

      response.when(
        success: (data) {
          log('Cart checkout completed successfully');
          emit(CheckoutState.loaded(data));
        },
        failure: (error) {
          _handleCheckoutError(error.message);
        },
      );
    } catch (e) {
      _handleUnexpectedError(e);
    }
  }

  Future<String?> _getCityId() async {
    final cityId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userAreaId);
    log('City ID: $cityId');
    return cityId;
  }

  CheckoutRequest _buildCheckoutRequest({
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
    String? promoCode,
    String? promoId,
    String? giftCardID,
    String? from,
    String? to,
    String? message,
    bool? isHandWritten,
    String? qrImageUrl,
    String? signatureImageUrl,
    String? link,
    required String cityId,
  }) {
    return CheckoutRequest(
      startDate: startDate,
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
        deliveryTime: startDate,
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
      appliedPromoCode: promoCode != null && promoId != null
          ? AppliedPromoCode(code: promoCode, id: promoId)
          : null,
      giftCard: GiftCard(
        qrImageUrl: qrImageUrl,
        signatureImageUrl: signatureImageUrl,
        template: Template(
          id: giftCardID ?? '',
        ),
        from: from ?? '',
        to: to ?? '',
        message: message ?? '',
        link: link,
        handwriting: isHandWritten,
      ),
    );
  }

  void _handleCheckoutError(String? errorMessage) {
    final message = errorMessage ?? 'Unknown error occurred';
    log('Error in cart checkout: $message');
    emit(CheckoutState.error(message: message));
  }

  void _handleUnexpectedError(Object error) {
    if (isClosed) return;
    log('Exception in cart checkout: $error');
    emit(const CheckoutState.error(message: 'An unexpected error occurred'));
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
