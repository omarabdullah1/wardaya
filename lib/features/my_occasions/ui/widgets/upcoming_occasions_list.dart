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

// Update the class definition to accept onOccasionTap callback
class UpcomingOccasionsList extends StatelessWidget {
  final Function(MyOccasionItem)? onOccasionTap;

  const UpcomingOccasionsList({super.key, this.onOccasionTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOccasionsCubit, MyOccasionsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => Skeletonizer(
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
                );
              },
            ),
          ),
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
                  child: OccasionCard(occasion: occasions[index]),
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
        );
      },
    );
  }
}

class OccasionCard extends StatelessWidget {
  final MyOccasionItem occasion;

  const OccasionCard({super.key, required this.occasion});

  @override
  Widget build(BuildContext context) {
    // Format the date
    final dateFormat = DateFormat('MMM\ndd');
    final formattedDate = dateFormat.format(occasion.date);
    final month = formattedDate.split('\n')[0];
    final day = formattedDate.split('\n')[1];

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
            // Date container with month and day
            Container(
              width: 80.w,
              height: 80.h,
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
                    SizedBox(height: 4.h),
                    Text(
                      'Something else', // You can add more details here
                      style: TextStylesInter.font14GreyRegular,
                    ),
                  ],
                ),
              ),
            ),
            // Gift image and edit button - Fixed this part
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/gift.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
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
          ],
        ),
      ),
    );
  }
}
