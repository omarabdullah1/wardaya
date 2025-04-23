// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
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
  // Default country to Egypt
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
              'Recipient name',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.darkGray,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: widget.nameController,
              decoration: InputDecoration(
                hintText: 'Enter recipient name',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.grey,
                ),
                filled: true,
                fillColor: ColorsManager.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: ColorsManager.lightGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: ColorsManager.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: ColorsManager.mainRose),
                ),
                suffixIcon: InkWell(
                  onTap: () async {
                    await pickContact();
                  },
                  child: Icon(
                    Icons.contacts_outlined,
                    color: ColorsManager.mainRose,
                    size: 24.sp,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
            ),
          ],
        ),

        VerticalSpace(height: 16.h),
        // Phone number field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone number',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.darkGray,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace fixed width container with a flexible Wrap widget
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
                          if (widget.onCountryCodeChanged != null) {
                            widget.onCountryCodeChanged!(
                                '+${_selectedCountry.phoneCode}');
                          }
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
                            // Display country flag
                            Text(
                              _selectedCountry.flagEmoji,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
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
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: widget.phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,15}$'),
                      ),
                    ],
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
                        borderSide:
                            const BorderSide(color: ColorsManager.mainRose),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Future<bool> _checkContactsPermission() async {
    final permission = await FlutterContacts.requestPermission();
    return permission;
  }

  Future<void> pickContact() async {
    // Remove the setState wrapper around the async function
    final hasPermission = await _checkContactsPermission();
    if (!hasPermission) {
      // Handle permission denied
      await _checkContactsPermission();
    }

    try {
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        final fullContact = await FlutterContacts.getContact(contact.id);

        if (fullContact != null) {
          // Use setState correctly here to update the UI after async operations
          setState(() {
            widget.nameController.text = fullContact.displayName;

            if (fullContact.phones.isNotEmpty) {
              final phone = fullContact.phones.first.number;
              // Remove non-numeric characters
              widget.phoneController.text =
                  phone.replaceAll(RegExp(r'[^\d]'), '');
            }
          });
        }
      }
    } catch (e) {
      // Handle exception
      log('Error picking contact: $e');
    }
  }
}
