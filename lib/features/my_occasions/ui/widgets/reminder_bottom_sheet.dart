import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/home/logic/recipients/recipients_cubit.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';

import '../../../../core/routing/router_imports.dart';
import '../../../home/logic/recipients/recipients_state.dart';

class ReminderBottomSheet extends StatefulWidget {
  final MyOccasionItem? occasion;

  const ReminderBottomSheet({super.key, this.occasion});

  @override
  State<ReminderBottomSheet> createState() => _ReminderBottomSheetState();
}

class _ReminderBottomSheetState extends State<ReminderBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _occasionController = TextEditingController();
  String? _selectedRelationship;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _phoneController = TextEditingController();
  final String _countryCode = '+20'; // Default country code

  @override
  void initState() {
    super.initState();
    if (widget.occasion != null) {
      _nameController.text = widget.occasion!.name;
      _selectedDate = widget.occasion!.date;
    }
    // Fetch recipients data when sheet opens
    context.read<RecipientsCubit>().getRecipients();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _occasionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate bottom inset to adjust for keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        bottom: bottomInset > 0 ? bottomInset : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remind me about...',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              VerticalSpace(height: 16.h),
              Text(
                'Tell us a few details to save your reminder',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.grey.withAlpha((0.75 * 255).toInt()),
                ),
              ),
              VerticalSpace(height: 24.h),

              // Name field
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalSpace(height: 8.h),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
              VerticalSpace(height: 16.h),

              // Relationship field
              Text(
                'Relationship (Optional)',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalSpace(height: 8.h),
              BlocBuilder<RecipientsCubit, RecipientsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (recipients) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsManager.grey.withAlpha(
                              (0.3 * 255).toInt(),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedRelationship,
                            hint: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text('Select relationship',
                                  style: TextStyle(color: Colors.grey[600])),
                            ),
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey[600]),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            borderRadius: BorderRadius.circular(8.r),
                            items: recipients.map((recipient) {
                              return DropdownMenuItem<String>(
                                value: recipient.name,
                                child: Text(recipient.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRelationship = newValue;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              VerticalSpace(height: 16.h),

              // Occasion field
              Text(
                'Occasion',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalSpace(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Something else',
                    hint: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text('Select occasion',
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey[600]),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    borderRadius: BorderRadius.circular(8.r),
                    items: [
                      'Birthday',
                      'Anniversary',
                      'Wedding',
                      'Something else'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle occasion selection
                    },
                  ),
                ),
              ),
              VerticalSpace(height: 8.h),

              // Custom occasion field (if "Something else" is selected)
              TextField(
                controller: _occasionController,
                decoration: InputDecoration(
                  hintText: "What's the occasion?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: ColorsManager.grey.withAlpha(
                      (0.3 * 255).toInt(),
                    )),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
              VerticalSpace(height: 16.h),

              // Date field
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalSpace(height: 8.h),
              GestureDetector(
                onTap: () async {
                  // Get the current date to use as firstDate
                  final DateTime now = DateTime.now();

                  // Ensure initialDate is not before firstDate
                  final DateTime initialDate =
                      _selectedDate.isBefore(now) ? now : _selectedDate;

                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: now,
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorsManager.grey.withAlpha(
                      (0.3 * 255).toInt(),
                    )),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMMM').format(_selectedDate),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      const Icon(Icons.calendar_today,
                          color: ColorsManager.mainRose),
                    ],
                  ),
                ),
              ),
              VerticalSpace(height: 16.h),

              // Phone number field
              Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              VerticalSpace(height: 8.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            ColorsManager.grey.withAlpha((0.3 * 255).toInt()),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        // You might need to add the Egypt flag asset or use a package for country flags
                        SizedBox(width: 24.w, height: 16.h),
                        HorizontalSpace(width: 4.w),
                        Text(_countryCode),
                        HorizontalSpace(width: 4.w),
                        Icon(Icons.keyboard_arrow_down, size: 16.sp),
                      ],
                    ),
                  ),
                  HorizontalSpace(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
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
                          borderSide:
                              const BorderSide(color: ColorsManager.mainRose),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                    ),
                  ),
                ],
              ),
              VerticalSpace(height: 16.h),

              // Data safety message
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorsManager.mainRose.withAlpha(
                    (0.2 * 255).toInt(),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: ColorsManager.mainRose.withAlpha(
                    (0.2 * 255).toInt(),
                  )),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shield,
                      color: ColorsManager.mainRose,
                      size: 20.sp,
                    ),
                    HorizontalSpace(width: 8.w),
                    Expanded(
                      child: Text(
                        'Your data is safe! We will only use this when you use your wallet credit',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.mainRose,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpace(height: 24.h),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save reminder logic
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainRose,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Save Reminder',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              VerticalSpace(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
