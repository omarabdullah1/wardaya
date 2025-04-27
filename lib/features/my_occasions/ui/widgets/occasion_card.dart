import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';
import 'package:wardaya/features/home/data/models/home_occassions_response.dart';

class OccasionCard extends StatelessWidget {
  final OccassionsItem? occasion;
  final bool isLoading;

  const OccasionCard({
    super.key,
    required this.occasion,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.2 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLoading ? Colors.grey : Colors.transparent,
                image: !isLoading && occasion != null
                    ? DecorationImage(
                        image: NetworkImage(
                            HomeApiConstants.apiBaseUrlForImages +
                                occasion!.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isLoading ? context.el.loading : occasion?.name ?? 'Unknown',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.mainRose,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
