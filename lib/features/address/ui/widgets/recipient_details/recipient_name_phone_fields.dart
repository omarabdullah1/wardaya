// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/spacing.dart';

import '../../../../../core/theming/colors.dart';

class RecipientNamePhoneFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function(String)? onCountryCodeChanged;

  const RecipientNamePhoneFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    this.onCountryCodeChanged,
  });

  @override
  State<RecipientNamePhoneFields> createState() =>
      _RecipientNamePhoneFieldsState();
}

class _RecipientNamePhoneFieldsState extends State<RecipientNamePhoneFields> {
  // Default country to Saudi Arabia
  Country _selectedCountry = Country(
    phoneCode: '966',
    countryCode: 'SA',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'SAUDI ARABIA',
    example: '512345678',
    displayName: 'SAUDI ARABIA (SA) [+966]',
    displayNameNoCountryCode: 'SAUDI ARABIA (SA)',
    e164Key: '966-SA-0',
  );

  @override
  void initState() {
    super.initState();

    // Set the initial country code when the widget initializes
    if (widget.onCountryCodeChanged != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCountryCodeChanged!('+${_selectedCountry.phoneCode}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Recipient name field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.el.recipientDetailsScreenRecipientNameLabel,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.darkGray,
              ),
            ),
            VerticalSpace(height: 8.h),
            TextFormField(
              controller: widget.nameController,
              decoration: InputDecoration(
                hintText: context.el.enterRecipientName,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.lightGrey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: ColorsManager.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.contact_phone, size: 24.sp),
                  onPressed: _selectContact,
                  color: ColorsManager.mainRose,
                ),
              ),
            ),
          ],
        ),
        VerticalSpace(height: 24.h),

        // Phone number field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.el.recipientDetailsScreenRecipientPhoneLabel,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.darkGray,
              ),
            ),
            VerticalSpace(height: 8.h),
            TextFormField(
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10), // Limit to 10 digits
              ],
              decoration: InputDecoration(
                hintText: context.el.enterPhoneNumber,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.lightGrey,
                ),
                prefixIcon: GestureDetector(
                  onTap: _showCountryPicker,
                  child: Container(
                    margin: EdgeInsets.only(right: 4.w),
                    padding: EdgeInsets.only(left: 12.w, right: 8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+${_selectedCountry.phoneCode}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 16.sp,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 4.w),
                        Container(
                          width: 1,
                          height: 24.h,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: ColorsManager.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                // Right-aligned icon for contacts
                suffixIcon: IconButton(
                  icon: Icon(Icons.contact_phone, size: 24.sp),
                  onPressed: _selectContact,
                  color: ColorsManager.mainRose,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.sp, color: Colors.blueGrey),
        bottomSheetHeight: 500.h,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        inputDecoration: InputDecoration(
          labelText: context
              .el.searchOrderPlaceholder, // Using existing key for search
          hintText: context.el.searchPlaceholder,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsManager.mainRose.withAlpha((0.2 * 255).toInt()),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });

        if (widget.onCountryCodeChanged != null) {
          widget.onCountryCodeChanged!('+${country.phoneCode}');
        }
      },
    );
  }

  void _selectContact() async {
    if (await FlutterContacts.requestPermission()) {
      try {
        // Show contact picker
        final contact = await FlutterContacts.openExternalPick();
        if (contact != null) {
          // Load contact with full details
          final fullContact = await FlutterContacts.getContact(contact.id);
          if (fullContact != null) {
            // Update name and phone fields
            if (fullContact.name.first.isNotEmpty ||
                fullContact.name.last.isNotEmpty) {
              widget.nameController.text =
                  '${fullContact.name.first} ${fullContact.name.last}';
            }

            if (fullContact.phones.isNotEmpty) {
              final phoneNumber = fullContact.phones.first.number;
              log('Full phone number: $phoneNumber');

              // Format phone number if needed: remove country code and special chars
              String formattedNumber =
                  phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

              // Remove country code if it's part of the number
              if (formattedNumber.startsWith(_selectedCountry.phoneCode)) {
                formattedNumber = formattedNumber
                    .substring(_selectedCountry.phoneCode.length);
              }

              widget.phoneController.text = formattedNumber;
            }
          }
        }
      } catch (e) {
        log('Error selecting contact: $e');
      }
    }
  }
}
