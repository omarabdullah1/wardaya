import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_cubit.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_state.dart';

class ReminderBottomSheet extends StatefulWidget {
  final MyOccasionItem? occasion;
  final bool isEdit;

  const ReminderBottomSheet({
    super.key,
    this.occasion,
    this.isEdit = false,
  });

  @override
  State<ReminderBottomSheet> createState() => _ReminderBottomSheetState();
}

class _ReminderBottomSheetState extends State<ReminderBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.occasion != null) {
      _nameController.text = widget.occasion!.name;
      _selectedDate = widget.occasion!.date;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveOccasion() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name for the occasion')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final myOccasionsCubit = context.read<MyOccasionsCubit>();

    if (widget.isEdit && widget.occasion != null) {
      // Update existing occasion
      myOccasionsCubit.updateOccasion(
        widget.occasion!.id,
        _nameController.text,
        _selectedDate,
      );
    } else {
      // Create new occasion
      myOccasionsCubit.createOccasion(
        _nameController.text,
        _selectedDate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate bottom inset to adjust for keyboard
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<MyOccasionsCubit, MyOccasionsState>(
      listener: (context, state) {
        state.maybeWhen(
          actionLoading: () {
            setState(() => _isLoading = true);
          },
          actionSuccess: (message, occasion) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            Navigator.pop(context, true);
          },
          actionError: (message) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $message')),
            );
          },
          orElse: () {},
        );
      },
      child: Container(
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
                      widget.isEdit ? 'Edit Occasion' : 'Remind me about...',
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
                  widget.isEdit
                      ? 'Update your occasion details'
                      : 'Tell us a few details to save your reminder',
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
                      borderSide:
                          const BorderSide(color: ColorsManager.mainRose),
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
                          DateFormat('dd MMMM yyyy').format(_selectedDate),
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        const Icon(Icons.calendar_today,
                            color: ColorsManager.mainRose),
                      ],
                    ),
                  ),
                ),
                VerticalSpace(height: 24.h),

                // Save/Update button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveOccasion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainRose,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            widget.isEdit
                                ? 'Update Occasion'
                                : 'Create Occasion',
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
      ),
    );
  }
}
