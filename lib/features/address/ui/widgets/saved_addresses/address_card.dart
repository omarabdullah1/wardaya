import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../../core/assets/assets.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../data/models/address_response.dart';

class AddressCard extends StatelessWidget {
  final Address? address;
  final VoidCallback? onEditComplete;

  const AddressCard({
    super.key,
    required this.address,
    this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
         Map<String, dynamic> arguments = {
                              'expressDelivery': true,
                              'extraArgs':
                                  address,
                            };
        final result = await context.pushNamed(
          Routes.recipientDetailsScreen,
          arguments: arguments,
        );

        if (result == true && onEditComplete != null) {
          onEditComplete!();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 8.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location pin icon
            Container(
              margin: EdgeInsets.only(top: 2.h, right: 12.w),
              child: SvgPicture.asset(
                Assets.of(context).svgs.location_icon_svg,
                height: 24.h,
                width: 24.w,
                colorFilter: const ColorFilter.mode(
                  ColorsManager.mainRose,
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Address details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address?.title ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    address?.recipientAddress ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorsManager.darkGray,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    address?.recipientArea ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorsManager.darkGray,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Name: ${address?.title ?? ''}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorsManager.darkGray,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Phone number: ${address?.userId ?? ''}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ColorsManager.darkGray,
                    ),
                  ),
                ],
              ),
            ),

            // Right arrow icon
            Container(
              padding: EdgeInsets.only(top: 8.h),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorsManager.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
