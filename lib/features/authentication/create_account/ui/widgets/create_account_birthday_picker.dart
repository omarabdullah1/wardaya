import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../logic/cubit/register_cubit.dart';
import '../../logic/cubit/register_state.dart';

class CreateAccountBirthdayPicker extends StatelessWidget {
  const CreateAccountBirthdayPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2012),
            ).then((value) {
              if (value != null) {
                cubit.setBirthDate(value);
              }
            });
          },
          child: Container(
            height: 40.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: ColorsManager.grey,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.selectedBirthDate.isNullOrEmpty()
                        ? context.el.birthdayLabel
                        : cubit.selectedBirthDate,
                    style: TextStylesInter.font15GreyRegular,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: ColorsManager.mainRose,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
