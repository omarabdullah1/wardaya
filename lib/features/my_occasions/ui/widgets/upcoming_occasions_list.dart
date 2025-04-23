import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_cubit.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_state.dart';
import 'package:wardaya/features/my_occasions/ui/widgets/reminder_bottom_sheet.dart';

// Update the class definition to accept onOccasionTap callback
class UpcomingOccasionsList extends StatelessWidget {
  final Function(MyOccasionItem)? onOccasionTap;
  final Function(MyOccasionItem)? onOccasionEdit;
  final Function(MyOccasionItem)? onOccasionDelete;

  const UpcomingOccasionsList({
    super.key,
    this.onOccasionTap,
    this.onOccasionEdit,
    this.onOccasionDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOccasionsCubit, MyOccasionsState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const SizedBox.shrink(),
          actionLoading: () => _buildLoading(context),
          loading: () => _buildLoading(context),
          success: (occasions) {
            if (occasions.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No upcoming occasions found'),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: occasions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onOccasionTap?.call(occasions[index]),
                  child: OccasionCard(
                    occasion: occasions[index],
                    onEdit: () => _showEditSheet(context, occasions[index]),
                    onDelete: () => _confirmDelete(context, occasions[index]),
                  ),
                );
              },
            );
          },
          error: (message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error: $message',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  void _showEditSheet(BuildContext context, MyOccasionItem occasion) {
    if (onOccasionEdit != null) {
      onOccasionEdit!(occasion);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<MyOccasionsCubit>(),
        child: ReminderBottomSheet(
          occasion: occasion,
          isEdit: true,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, MyOccasionItem occasion) {
    if (onOccasionDelete != null) {
      onOccasionDelete!(occasion);
      return;
    }

    // Store the cubit reference before showing the dialog
    final myOccasionsCubit = context.read<MyOccasionsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Occasion'),
        content: Text('Are you sure you want to delete "${occasion.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Use the stored cubit reference instead of trying to access it from the dialog context
              myOccasionsCubit.deleteOccasion(occasion.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return OccasionCard(
            occasion: MyOccasionItem(
              id: '1',
              name: 'Loading...',
              date: DateTime.now(),
              version: 1,
            ),
            onEdit: null,
            onDelete: null,
          );
        },
      ),
    );
  }
}

class OccasionCard extends StatelessWidget {
  final MyOccasionItem occasion;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const OccasionCard({
    super.key,
    required this.occasion,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Format the date to include year
    final dateFormat = DateFormat('MMM\ndd\nyyyy');
    final formattedDate = dateFormat.format(occasion.date);
    final dateParts = formattedDate.split('\n');
    final month = dateParts[0];
    final day = dateParts[1];
    final year = dateParts[2];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Date container with month, day and year
            Container(
              width: 80.w,
              height: 90.h, // Increased height to accommodate the year
              decoration: const BoxDecoration(
                color: ColorsManager.mainRose,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    year,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Occasion details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      occasion.name,
                      style: TextStylesInter.font16BlackSemiBold,
                    ),
                  ],
                ),
              ),
            ),
            // Actions column with edit and delete buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button
                if (onEdit != null)
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: GestureDetector(
                      onTap: onEdit,
                      child: Column(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: ColorsManager.mainRose.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: ColorsManager.mainRose,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: ColorsManager.mainRose,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Delete button
                if (onDelete != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8.0.w, left: 8.0.w),
                    child: GestureDetector(
                      onTap: onDelete,
                      child: Column(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
