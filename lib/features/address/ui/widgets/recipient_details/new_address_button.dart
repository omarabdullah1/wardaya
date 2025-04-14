import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../logic/address_cubit/address_cubit.dart';

class NewAddressButton extends StatelessWidget {
  const NewAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
      
        final result = await context.pushNamed(
          Routes.recipientDetailsScreen,
        );

        if (result == true) {
          // If address was added, refresh the list
          if (context.mounted) {
            context.read<AddressCubit>().getAddresses();
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorsManager.lightLighterGrey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: ColorsManager.black87,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                context.el.addressesScreenAddNewAddressButton,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
