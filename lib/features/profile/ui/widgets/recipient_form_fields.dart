import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

class RecipientNameField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPickContact;

  const RecipientNameField({
    super.key,
    required this.controller,
    required this.onPickContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: controller,
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
              onTap: onPickContact,
              child: Icon(
                Icons.contacts_outlined,
                color: ColorsManager.darkGray,
                size: 24.sp,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          children: [
            Container(
              width: 85.w,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorsManager.lightGrey),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Using a placeholder for the flag
                  Container(
                    width: 22.w,
                    height: 16.h,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'EG',
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '+20',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.black,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ColorsManager.darkGray,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '1234567890',
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AreaField extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const AreaField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkGray,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorsManager.lightGrey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: ColorsManager.darkGray,
                size: 30.sp,
              ),
              items: ['Zahraa El Maadi', 'Maadi', 'New Cairo', 'Heliopolis']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorsManager.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class AddressField extends StatelessWidget {
  final TextEditingController controller;

  const AddressField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkGray,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: '15b Cairo - Sweis Rd, El-Basatin Sharkeya, Tura,',
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}

class ExtraAddressField extends StatelessWidget {
  final TextEditingController controller;

  const ExtraAddressField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Extra address details(Optional)',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkGray,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Apartment number, floor, landmark, etc.',
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}
