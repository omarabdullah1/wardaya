import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_cubit.dart';
import 'widgets/occasions_builder.dart';
import 'widgets/upcoming_occasions_list.dart';
import 'widgets/reminder_bottom_sheet.dart';

class OccasionsScreen extends StatelessWidget {
  const OccasionsScreen({super.key});

  void _showReminderBottomSheet(BuildContext context,
      {MyOccasionItem? occasion}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReminderBottomSheet(occasion: occasion),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: const AppAppBar(title: 'context.el.myOccasions'),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorsManager.mainRose,
          onRefresh: () async {
            context.read<MyOccasionsCubit>().getMyOccasions();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Text(
                    'context.el.quickAdd',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Text(
                    'context.el.selectAnOccasionToCreateAReminder',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                VerticalSpace(height: 16.h),
                OccasionsBuilder(
                    onOccasionTap: (occasion) =>
                        _showReminderBottomSheet(context, occasion: occasion)),
                VerticalSpace(height: 24.h),
                Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Text(
                    'context.el.yourUpcomingOccasion',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UpcomingOccasionsList(
                    onOccasionTap: (occasion) =>
                        _showReminderBottomSheet(context, occasion: occasion)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
