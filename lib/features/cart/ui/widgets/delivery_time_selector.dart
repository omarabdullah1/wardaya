import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/font_weight_helper.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/checkout/checkout_cubit.dart';

class DeliveryTimeSelector extends StatefulWidget {
  final CheckoutCubit checkoutCubit;
  const DeliveryTimeSelector({super.key, required this.checkoutCubit});

  @override
  State<DeliveryTimeSelector> createState() => _DeliveryTimeSelectorState();
}

class _DeliveryTimeSelectorState extends State<DeliveryTimeSelector> {
  String _selectedDate = '';
  // String _selectedTimeSlot = '';
  bool _isTomorrowSelected = false;
  bool _isCustomDateSelected = false;

  @override
  void initState() {
    super.initState();
    // Initialize with values from cubit if they exist
    final checkoutCubit = widget.checkoutCubit;
    if (checkoutCubit.selectedDeliveryDate.isNotEmpty) {
      _selectedDate = checkoutCubit.selectedDeliveryDate;

      // Determine if the selected date is tomorrow
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final tomorrowFormatted = DateFormat('dd MMMM yyyy').format(tomorrow);

      if (_selectedDate == tomorrowFormatted) {
        _isTomorrowSelected = true;
        widget.checkoutCubit.updateDeliveryDateTime(_selectedDate, tomorrow);
      } else {
        _isCustomDateSelected = true;
      }
      // widget.checkoutCubit.updateDeliveryDateTime(_selectedDate, DateTime.now());

      // if (checkoutCubit.selectedDeliveryTime.isNotEmpty) {
      //   _selectedTimeSlot = checkoutCubit.selectedDeliveryTime;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: ColorsManager.white,
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.el.deliveryDate,
            style: TextStylesInter.font16BlackSemiBold.copyWith(
              color: ColorsManager.mainRose,
            ),
          ),
          SizedBox(height: 12.h),

          // Date selection boxes
          Row(
            children: [
              // Tomorrow box
              Expanded(
                child: _buildDateBox(
                  title: 'Tomorrow',
                  date: _getTomorrowDate(),
                  isSelected: _isTomorrowSelected,
                  onTap: () => _selectTomorrow(),
                ),
              ),
              SizedBox(width: 10.w),
              // Custom date box
              Expanded(
                child: _buildDateBox(
                  title: _isCustomDateSelected && _selectedDate.isNotEmpty
                      ? _selectedDate
                      : 'Select Date',
                  isCentered: true,
                  date: null,
                  isSelected: _isCustomDateSelected,
                  onTap: () => _openDatePicker(context),
                  showCalendarIcon: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox({
    required String title,
    String? date,
    bool isSelected = false,
    bool isCentered = false,
    required VoidCallback onTap,
    bool showCalendarIcon = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.mainRose.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color:
                isSelected ? ColorsManager.mainRose : ColorsManager.lightGrey,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showCalendarIcon)
                  Icon(
                    Icons.calendar_today,
                    color: isSelected
                        ? ColorsManager.mainRose
                        : ColorsManager.grey,
                    size: 35.sp,
                  ),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? ColorsManager.mainRose
                        : ColorsManager.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (date != null) ...[
              SizedBox(height: 4.h),
              Text(
                date,
                style: GoogleFonts.inter(
                  color:
                      isSelected ? ColorsManager.mainRose : ColorsManager.grey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Get tomorrow's date as a formatted string
  String _getTomorrowDate() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return DateFormat('dd MMM').format(tomorrow);
  }

  // Select tomorrow as the delivery date
  void _selectTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowFormatted = DateFormat('dd MMMM yyyy').format(tomorrow);

    setState(() {
      _isTomorrowSelected = true;
      _isCustomDateSelected = false;
      _selectedDate = tomorrowFormatted;
      // if (_selectedTimeSlot.isEmpty) {
      //   _selectedTimeSlot = ''; // Reset time slot when changing date
      // }
    });
    widget.checkoutCubit.updateDeliveryDateTime(_selectedDate, tomorrow);

    // Update cubit if a time slot is already selected
    // if (_selectedTimeSlot.isNotEmpty) {
    //   context.read<CheckoutCubit>().updateDeliveryDateTime(
    //         _selectedDate,
    //         _selectedTimeSlot,
    //       );
    // }
  }

  // Open date picker for custom date selection
  Future<void> _openDatePicker(BuildContext context) async {
    // Get tomorrow as the minimum date
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    // Show date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.mainRose,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Format the selected date
      final formattedDate = DateFormat('dd MMMM yyyy').format(pickedDate);

      // Check if the selected date is tomorrow
      final tomorrowDate = DateTime.now().add(const Duration(days: 1));
      final isTomorrow = pickedDate.year == tomorrowDate.year &&
          pickedDate.month == tomorrowDate.month &&
          pickedDate.day == tomorrowDate.day;

      setState(() {
        _selectedDate = formattedDate;
        _isTomorrowSelected = isTomorrow;
        _isCustomDateSelected = !isTomorrow;
        // if (_selectedTimeSlot.isEmpty) {
        //   _selectedTimeSlot = ''; // Reset time slot when changing date
        // }
      });
      widget.checkoutCubit.updateDeliveryDateTime(_selectedDate, pickedDate);

      // Update cubit if a time slot is already selected
      // if (_selectedTimeSlot.isNotEmpty) {
      //   context.read<CheckoutCubit>().updateDeliveryDateTime(
      //         _selectedDate,
      //         _selectedTimeSlot,
      //       );
      // }
    }
  }
}
