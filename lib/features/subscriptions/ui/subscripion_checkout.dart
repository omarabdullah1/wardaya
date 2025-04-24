import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/core/widgets/app_text_button.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/address/data/models/address_response.dart';
import 'package:wardaya/features/address/logic/address_cubit/address_cubit.dart';
import 'package:wardaya/features/address/logic/address_cubit/address_state.dart';
import 'package:wardaya/features/subscriptions/logic/subscription_checkout_cubit/subscription_checkout_cubit.dart';
import 'package:wardaya/features/subscriptions/logic/subscription_checkout_cubit/subscription_checkout_state.dart';
import 'package:wardaya/features/subscriptions/ui/address_option_preview.dart';
import 'package:wardaya/features/subscriptions/ui/recipient_address_sheet.dart';

import '../../../core/assets/assets.dart';

class SubscripionCheckout extends StatefulWidget {
  const SubscripionCheckout({
    super.key,
    required this.subscriptionPlan,
    required this.deliveryFrequency,
    required this.subscriptionDuration,
    required this.startDate,
    required this.price,
    required this.currency,
  });

  final String subscriptionPlan;
  final String deliveryFrequency;
  final String subscriptionDuration;
  final String startDate;
  final String price;
  final String currency;

  @override
  State<SubscripionCheckout> createState() => _SubscripionCheckoutState();
}

class _SubscripionCheckoutState extends State<SubscripionCheckout> {
  String selectedAddressOption = '';
  String selectedPaymentMethod = '';
  bool saveAddress = true;
  bool showUserRecipient =
      false; // Added to toggle between saved addresses and manual entry
  // Default country to Saudi Arabia
  Country _selectedCountry = Country(
    phoneCode: '966',
    countryCode: 'SA',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Saudi Arabia',
    example: '501234567',
    displayName: 'Saudi Arabia (SA) [+966]',
    displayNameNoCountryCode: 'Saudi Arabia (SA)',
    e164Key: '966-SA-0',
  );

  void _handleAddressOptionChange(String? value) async {
    if (value != null) {
      final addressCubit = context.read<AddressCubit>();
      final addresses = (addressCubit.state as Success).addresses;

      // Check if the selected option is a saved address
      bool isSavedAddress =
          addresses.any((address) => address.recipientAddress == value);

      // Set the selected option immediately for responsive UI
      setState(() {
        selectedAddressOption = value;
        showUserRecipient = !isSavedAddress;
      });

      if (value == 'Enter recipient address') {
        final cubit = context.read<SubscriptionCheckoutCubit>();

        // Show bottom sheet for recipient address - always show when selected
        final result = await showModalBottomSheet<Map<String, dynamic>>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RecipientAddressSheet(
            initialLocation:
                cubit.selectedLocation ?? const LatLng(24.0444, 46.2357),
            initialAddress: cubit.selectedAddress,
            initialArea: cubit.selectedArea,
            additional: cubit.additionalInfo,
          ),
        );

        // Handle the result from the bottom sheet
        if (result != null) {
          cubit.updateLocationData(
            result['location'] as LatLng,
            result['address'] as String,
            result['area'] as String,
            result['additional'] as String,
          );
        } else {
          // If user cancels and there's no existing location, revert the selection
          if (cubit.selectedLocation == null) {
            setState(() {
              selectedAddressOption = '';
              showUserRecipient = false;
            });
          }
        }
      } else if (isSavedAddress) {
        // If a saved address is selected, populate the name and phone fields
        final selectedAddress = addresses
            .firstWhere((address) => address.recipientAddress == value);
        final cubit = context.read<SubscriptionCheckoutCubit>();
        cubit.nameController.text = selectedAddress.recipientName ?? '';
        cubit.phoneController.text = selectedAddress.recipientPhoneNumber ?? '';
      }
    }
  }

  void _handlePaymentMethodChange(String? value) {
    if (value != null) {
      setState(() {
        selectedPaymentMethod = value;
      });
    }
  }

  Future<void> _handleProceedToPayment(String name, String phone) async {
    final cubit = context.read<SubscriptionCheckoutCubit>();

    if (name.isEmpty ||
        phone.isEmpty ||
        selectedAddressOption.isEmpty ||
        selectedPaymentMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: ColorsManager.mainRose,
        ),
      );
      return;
    }

    // Convert source_id based on payment method
    String sourceId = '';
    switch (selectedPaymentMethod) {
      case 'Credit Card':
        sourceId = 'src_card';
        break;
      case 'Mada':
        sourceId = 'src_sa.mada';
        break;
      case 'Google Pay':
        sourceId = 'src_google_pay';
        break;
      case 'Apple Pay':
        sourceId = 'src_apple_pay';
        break;
      case 'STC Pay':
        sourceId = 'src_sa.stcpay';
        break;
      default:
        sourceId = 'src_all';
    }

    // Get location data and area based on selection
    final location = selectedAddressOption == 'Enter recipient address'
        ? cubit.selectedLocation ?? const LatLng(0, 0)
        : const LatLng(0, 0);

    final address = selectedAddressOption == 'Enter recipient address'
        ? cubit.selectedAddress
        : '';

    final area = selectedAddressOption == 'Enter recipient address'
        ? cubit.selectedArea
        : 'To be provided by recipient';

    final keepIdentitySecret =
        selectedAddressOption == 'Ask the recipient for the address';

    cubit.checkout(
      plan: widget.subscriptionPlan,
      deliveryFrequency: widget.deliveryFrequency,
      duration: widget.subscriptionDuration,
      startDate: widget.startDate,
      amount: widget.price,
      currency: widget.currency,
      description: 'notes for wardaya',
      sourceId: sourceId,
      name: name,
      code: '+${_selectedCountry.phoneCode}',
      phone: phone,
      location: location,
      address: address,
      area: area,
      keepIdentitySecret: keepIdentitySecret,
      additionalInfo: cubit.additionalInfo,
      saveAddress: saveAddress,
    );
  }

  String calculateNextPaymentDate() {
    // Parse the start date, removing the day name
    final dateStr = widget.startDate.split(', ')[1]; // Get "17/4/2025" part
    final dateParts = dateStr.split('/');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    // Extract number of months from duration (e.g. "3 Months" -> 3)
    final durationValue = int.parse(widget.subscriptionDuration.split(' ')[0]);

    // Add months to current date
    final nextPayment = DateTime(year, month + durationValue, day);

    // Format back as dd/MM/yyyy
    return "${nextPayment.day}/${nextPayment.month}/${nextPayment.year}";
  }

  void _handleSavedAddressToggle(bool value) {
    setState(() {
      showUserRecipient = !value;
    });

    // If toggling to show saved addresses, load them
    if (!showUserRecipient) {
      context.read<AddressCubit>().getAddresses();
      // Clear the manual address selection since we're using saved addresses
      if (selectedAddressOption == 'Ask the recipient for the address' ||
          selectedAddressOption == 'Enter recipient address') {
        setState(() {
          selectedAddressOption = '';
        });
      }
    } else {
      // Clear selected address if switching back to manual entry and no option is selected
      if (selectedAddressOption.isNotEmpty &&
          selectedAddressOption != 'Ask the recipient for the address' &&
          selectedAddressOption != 'Enter recipient address') {
        setState(() {
          selectedAddressOption = '';
        });
      }
    }
  }

  void _handleSelectAddress(Address address) {
    final cubit = context.read<SubscriptionCheckoutCubit>();
    setState(() {
      // Set the selected address
      selectedAddressOption = address.id;
    });

    // Update checkout cubit with selected address data
    if (address.latitude != 0 && address.longitude != 0) {
      cubit.updateLocationData(
        LatLng(address.latitude, address.longitude),
        address.recipientAddress,
        address.recipientArea,
        address.extraAddressDetails,
      );
    }

    // Update recipient name and phone if available
    if (address.recipientName != null && address.recipientName!.isNotEmpty) {
      cubit.nameController.text = address.recipientName!;
    }

    if (address.recipientPhoneNumber != null &&
        address.recipientPhoneNumber!.isNotEmpty) {
      cubit.phoneController.text = address.recipientPhoneNumber!;
    }
  }

  Widget _buildSavedAddressesList() {
    // This fetches and displays saved addresses
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: const CircularProgressIndicator(
                  color: ColorsManager.mainRose),
            ),
          ),
          success: (addresses) {
            if (addresses.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Column(
                      children: [
                        Icon(Icons.location_off,
                            size: 48.w, color: Colors.grey),
                        VerticalSpace(height: 8.h),
                        Text(
                          'No saved addresses found',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.grey,
                          ),
                        ),
                        VerticalSpace(height: 16.h),
                        AppTextButton(
                          buttonText: 'Add New Address',
                          onPressed: () {
                            // Switch to manual entry mode
                            setState(() {
                              showUserRecipient = true;
                            });
                          },
                          textStyle:
                              TextStylesInter.font14BlackSemiBold.copyWith(
                            color: ColorsManager.white,
                          ),
                          backgroundColor: ColorsManager.mainRose,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select a saved address",
                  style: TextStylesInter.font14BlackRegular.copyWith(
                    color: ColorsManager.mainRose,
                  ),
                ),
                VerticalSpace(height: 12.h),
                ...addresses.map((address) {
                  return GestureDetector(
                    onTap: () => _handleSelectAddress(address),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: selectedAddressOption == address.id
                              ? ColorsManager.mainRose
                              : Colors.grey[300]!,
                          width:
                              selectedAddressOption == address.id ? 2.0 : 1.0,
                        ),
                        boxShadow: selectedAddressOption == address.id
                            ? [
                                BoxShadow(
                                  color:
                                      ColorsManager.mainRose.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            // Circle with map pin icon
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: ColorsManager.mainRose.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: ColorsManager.mainRose,
                                  size: 24.w,
                                ),
                              ),
                            ),
                            HorizontalSpace(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (address.recipientName != null &&
                                      address.recipientName!.isNotEmpty)
                                    Text(
                                      address.recipientName!,
                                      style:
                                          TextStylesInter.font14BlackSemiBold,
                                    ),
                                  VerticalSpace(height: 4.h),
                                  Text(
                                    address.recipientAddress,
                                    style: TextStylesInter.font14BlackRegular
                                        .copyWith(
                                      color: ColorsManager.darkGray,
                                      fontWeight: FontWeightHelper.medium,
                                    ),
                                  ),
                                  if (address.recipientPhoneNumber != null &&
                                      address.recipientPhoneNumber!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: Text(
                                        address.recipientPhoneNumber!,
                                        style: TextStylesInter
                                            .font14BlackRegular
                                            .copyWith(
                                          color: ColorsManager.darkGray,
                                          fontWeight: FontWeightHelper.medium,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Radio(
                              value: address.id,
                              groupValue: selectedAddressOption,
                              onChanged: (value) {
                                if (value != null) {
                                  _handleSelectAddress(address);
                                }
                              },
                              activeColor: ColorsManager.mainRose,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          },
          error: (error) => Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                children: [
                  Icon(Icons.error_outline,
                      size: 48.w, color: ColorsManager.red),
                  VerticalSpace(height: 8.h),
                  Text(
                    'Error loading addresses: $error',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorsManager.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpace(height: 16.h),
                  AppTextButton(
                    buttonText: 'Try Again',
                    onPressed: () {
                      context.read<AddressCubit>().getAddresses();
                    },
                    textStyle: TextStylesInter.font14BlackSemiBold.copyWith(
                      color: ColorsManager.white,
                    ),
                    backgroundColor: ColorsManager.mainRose,
                  ),
                ],
              ),
            ),
          ),
          orElse: () => const Center(child: Text('No addresses available')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionCheckoutCubit, SubscriptionCheckoutState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          recipientSelected: (_, __) {},
          locationSelected: (_, __, ___, ____) {},
          loading: () {
            // Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const LoadingWidget(loadingState: true);
              },
            );
          },
          loaded: (response) {
            // Close loading dialog
            Navigator.pop(context);
            // Navigate to TapPaymentScreen with the redirect URL
            context.pushNamed(Routes.tapPaymentScreen, arguments: {
              'amount': double.parse(widget.price), // Including VAT
              'orderId': response.ordersId ?? '',
              'firstName': context
                  .read<SubscriptionCheckoutCubit>()
                  .nameController
                  .text
                  .split(' ')
                  .first,
              'lastName': context
                  .read<SubscriptionCheckoutCubit>()
                  .nameController
                  .text
                  .split(' ')
                  .skip(1)
                  .join(' '),
              'email':
                  '', // If email is required, you'll need to add it to the form
              'phoneNumber': context
                  .read<SubscriptionCheckoutCubit>()
                  .phoneController
                  .text,
              'countryCode': '+${_selectedCountry.phoneCode}',
              'paymentMethod': selectedPaymentMethod,
              'redirectUrl': response.redirectUrl,
            });
          },
          error: (message) {
            // Close loading dialog if open
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: ColorsManager.mainRose,
              ),
            );
          },
        );
      },
      child: BlocProvider<AddressCubit>(
        create: (context) => getIt<AddressCubit>()..getAddresses(),
        child: Scaffold(
          backgroundColor: ColorsManager.offWhite,
          appBar: const AppAppBar(title: 'Checkout'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Recipient Details'),
                  const VerticalSpace(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: ColorsManager.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w, vertical: 8.0.h),
                      child: _buildRecipientDetailsSection(),
                    ),
                  ),
                  const VerticalSpace(height: 24),
                  _buildSectionTitle('Payment Method'),
                  const VerticalSpace(height: 16),
                  _buildPaymentMethodsSection(),
                  const VerticalSpace(height: 24),
                  _buildSectionTitle('Payment Details'),
                  const VerticalSpace(height: 8),
                  _buildTotalSection(),
                  const VerticalSpace(height: 16),
                  _buildNextPaymentInfo(),
                  const VerticalSpace(height: 24),
                  _buildProceedButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStylesEBGaramond.font32MainRoseRegular,
    );
  }

  Widget _buildRecipientDetailsSection() {
    return BlocBuilder<SubscriptionCheckoutCubit, SubscriptionCheckoutState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCheckoutCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(height: 8),

            // Toggle switch between manual input and saved addresses
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Use saved addresses",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.black87,
                  ),
                ),
                Switch(
                  value: !showUserRecipient,
                  onChanged: _handleSavedAddressToggle,
                  activeColor: ColorsManager.mainRose,
                ),
              ],
            ),
            VerticalSpace(height: 16.h),

            // Show either delivery address options or saved addresses list
            if (showUserRecipient) ...[
              // Recipient Name and Phone Fields (only displayed when manual entry is selected)
              _buildTextField(
                'Recipient Name',
                'Enter Recipient Name',
                onTapSuffix: () {
                  cubit.pickContact();
                },
                cubit.nameController,
                suffixIcon: Icons.contacts_outlined,
              ),
              const VerticalSpace(height: 16),
              _buildPhoneField(cubit.phoneController),

              Text(
                'Delivery Address',
                style: TextStylesInter.font14BlackRegular.copyWith(
                  color: ColorsManager.mainRose,
                ),
              ),
              const VerticalSpace(height: 8),
              AddressOptionPreview(
                text: 'Ask the recipient for the address',
                isSelected: selectedAddressOption ==
                    'Ask the recipient for the address',
                groupValue: selectedAddressOption,
                onChanged: _handleAddressOptionChange,
              ),
              const VerticalSpace(height: 8),
              AddressOptionPreview(
                text: 'Enter recipient address',
                isSelected: selectedAddressOption == 'Enter recipient address',
                location: cubit.selectedLocation,
                address: cubit.selectedAddress,
                area: cubit.selectedArea,
                groupValue: selectedAddressOption,
                onChanged: _handleAddressOptionChange,
              ),
            ] else ...[
              _buildSavedAddressesList(),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    VoidCallback? onTapSuffix,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStylesInter.font16BlackSemiBold.copyWith(
            color: ColorsManager.mainRose,
          ),
        ),
        const VerticalSpace(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.grey,
            ),
            filled: true,
            fillColor: ColorsManager.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: ColorsManager.mainRose),
            ),
            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: onTapSuffix,
                    child: Icon(
                      suffixIcon,
                      color: ColorsManager.mainRose,
                      size: 24.sp,
                    ),
                  )
                : null,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Phone Number',
          style: TextStylesInter.font16BlackSemiBold.copyWith(
            color: ColorsManager.mainRose,
          ),
        ),
        const VerticalSpace(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                      });
                    },
                    countryListTheme: CountryListThemeData(
                      borderRadius: BorderRadius.circular(8.r),
                      inputDecoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.lightGrey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorsManager.lightGrey),
                  ),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _selectedCountry.flagEmoji,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        const HorizontalSpace(width: 4),
                        Text(
                          '+${_selectedCountry.phoneCode}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: ColorsManager.darkGray,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const HorizontalSpace(width: 8),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Ex:${_selectedCountry.example}',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.grey,
                  ),
                  filled: true,
                  fillColor: ColorsManager.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        const BorderSide(color: ColorsManager.lightGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        const BorderSide(color: ColorsManager.lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: ColorsManager.mainRose),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      children: [
        _buildPaymentOption(
          'Credit Card',
          Assets.of(context).pay_cards.master_card_png,
        ),
        // const VerticalSpace(height: 8),
        // _buildPaymentOption(
        //   'Mada',
        //   Assets.of(context).pay_cards.mada_png,
        // ),
        const VerticalSpace(height: 8),
        _buildPaymentOption(
          'Google Pay',
          Assets.of(context).pay_cards.gpay_png,
        ),
        // const VerticalSpace(height: 8),
        // _buildPaymentOption(
        //   'Apple Pay',
        //   Assets.of(context).pay_cards.apple_pay_png,
        // ),
        // const VerticalSpace(height: 8),
        // _buildPaymentOption(
        //   'STC Pay',
        //   Assets.of(context).pay_cards.stc_png,
        //   height: 10,
        // ),
        // const VerticalSpace(height: 8),
        // _buildPaymentOption(
        //   'Paypal',
        //   Assets.of(context).pay_cards.paypal_png,
        // ),
      ],
    );
  }

  Widget _buildPaymentOption(String text, String assetPath,
      {double height = 24}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.white,
        border: Border.all(
          color: selectedPaymentMethod == text
              ? ColorsManager.mainRose
              : ColorsManager.transparent,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: RadioListTile(
        value: text,
        groupValue: selectedPaymentMethod,
        onChanged: _handlePaymentMethodChange,
        title: Row(
          children: [
            Image.asset(
              assetPath,
              height: height.h,
            ),
            const HorizontalSpace(width: 8),
            Text(
              text,
              style: TextStylesInter.font14MainRoseSemiBold
                  .copyWith(fontWeight: FontWeightHelper.bold),
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First delivery payment details',
          style: TextStylesInter.font14DarkGrayBold.copyWith(
            color: ColorsManager.lighterLightGrey,
          ),
        ),
        const VerticalSpace(height: 16),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPriceRow('Subtotal', '${widget.currency} ${widget.price}'),
              const VerticalSpace(height: 8),
              _buildPriceRow('Delivery charges', 'Free'),
              const VerticalSpace(height: 8),
              _buildPriceRow('Total (15.0% VAT Included)',
                  '${widget.currency} ${(double.parse(widget.price)).toStringAsFixed(2)}',
                  isBold: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStylesInter.font14BlackRegular.copyWith(
            fontWeight:
                isBold ? FontWeightHelper.bold : FontWeightHelper.regular,
          ),
        ),
        Text(
          amount,
          style: TextStylesInter.font14BlackRegular.copyWith(
            fontWeight:
                isBold ? FontWeightHelper.bold : FontWeightHelper.regular,
          ),
        ),
      ],
    );
  }

  Widget _buildNextPaymentInfo() {
    return Row(
      children: [
        Icon(Icons.info_outline, color: Colors.grey[600], size: 20.w),
        const HorizontalSpace(width: 8),
        Text(
          'Next payment ${calculateNextPaymentDate()}',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return AppTextButton(
      buttonText: 'Proceed To Payment',
      textStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      onPressed: () {
        _handleProceedToPayment(
          context.read<SubscriptionCheckoutCubit>().nameController.text,
          context.read<SubscriptionCheckoutCubit>().phoneController.text,
        );
      },
    );
  }
}
