import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/subscriptions/logic/plans/subscription_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/router_imports.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/plans/subscription_state.dart';

class BuildStartingDateRadioList extends StatelessWidget {
  final List<String> options;
  final String? selectedDate;

  const BuildStartingDateRadioList({
    super.key,
    required this.options,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // Access localization outside of BlocBuilder
    final String selectOtherDate = context.el.selectOtherDate;

    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCubit>();
        return Column(
          children: options.map((option) {
            final bool isSelected = option == cubit.selectedDate ||
                (option == selectOtherDate &&
                    cubit.selectedDate != null &&
                    !options.contains(cubit.selectedDate) &&
                    cubit.selectedDate != selectOtherDate);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.mainRose
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioTheme(
                  data: RadioThemeData(
                    fillColor: WidgetStateProperty.all(
                      ColorsManager.lighterLightGrey,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        option == selectOtherDate &&
                                                cubit.selectedDate != null &&
                                                !options.contains(
                                                    cubit.selectedDate)
                                            ? cubit.selectedDate!
                                            : option,
                                        style: isSelected
                                            ? TextStylesInter.font16MainRoseBold
                                            : TextStylesInter
                                                .font16MainRoseNormal,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const HorizontalSpace(width: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const HorizontalSpace(width: 10),
                          if (option == selectOtherDate ||
                              (option == cubit.selectedDate &&
                                  !options
                                      .sublist(0, options.length - 1)
                                      .contains(option)))
                            IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2025),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null) {
                                  String formattedDate =
                                      DateFormat('EEE, d/M/yyyy')
                                          .format(picked);

                                  cubit.setSelectedDate(formattedDate);
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_today_outlined,
                                color: ColorsManager.mainRose,
                              ),
                            ),
                        ],
                      ),
                    ),
                    value: option == selectOtherDate &&
                            cubit.selectedDate != null &&
                            !options.contains(cubit.selectedDate)
                        ? selectOtherDate
                        : option,
                    groupValue: option == selectOtherDate &&
                            cubit.selectedDate != null &&
                            !options.contains(cubit.selectedDate)
                        ? selectOtherDate
                        : cubit.selectedDate,
                    onChanged: (value) async {
                      if (option == selectOtherDate) {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          String formattedDate =
                              DateFormat('EEE, d/M/yyyy').format(picked);
                          cubit.setSelectedDate(formattedDate);
                        }
                      } else {
                        cubit.setSelectedDate(value!);
                      }
                    },
                    activeColor: ColorsManager.mainRose,
                    overlayColor:
                        WidgetStateProperty.all(ColorsManager.mainRose),
                    splashRadius: 10.0.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class BuildDeliveryRadioList extends StatelessWidget {
  final List<String> options;

  const BuildDeliveryRadioList({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCubit>();
        return Column(
          children: options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  border: Border.all(
                    color: option == cubit.deliveryFrequency
                        ? ColorsManager.mainRose
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioTheme(
                  data: RadioThemeData(
                    fillColor: WidgetStateProperty.all(
                      ColorsManager.lighterLightGrey,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              option,
                              style: option == cubit.deliveryFrequency
                                  ? TextStylesInter.font16MainRoseBold
                                  : TextStylesInter.font16MainRoseNormal,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: option,
                    groupValue: cubit.deliveryFrequency,
                    onChanged: (value) async {
                      cubit.setDeliveryFrequency(value!);
                    },
                    activeColor: ColorsManager.mainRose,
                    overlayColor:
                        WidgetStateProperty.all(ColorsManager.mainRose),
                    splashRadius: 10.0.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class BuildSubscriptionRadioList extends StatelessWidget {
  final List<String> options;
  final List<String>? deliveries;
  final List<String>? prices;
  final List<String>? optionsOffValue;

  const BuildSubscriptionRadioList({
    super.key,
    required this.options,
    this.deliveries,
    this.prices,
    this.optionsOffValue,
  });

  @override
  Widget build(BuildContext context) {
    // Store localization strings outside BlocBuilder
    final String offText = context.el.off;
    final String perDeliveryText = context.el.perDelivery;
    final String selectOtherDateText = context.el.selectOtherDate;

    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final cubit = context.read<SubscriptionCubit>();
        return Column(
          children: options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  border: Border.all(
                    color: option == cubit.subscriptionDuration
                        ? ColorsManager.mainRose
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioTheme(
                  data: RadioThemeData(
                    fillColor: WidgetStateProperty.all(
                      ColorsManager.lighterLightGrey,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        option,
                                        style: option ==
                                                cubit.subscriptionDuration
                                            ? TextStylesInter.font16MainRoseBold
                                            : TextStylesInter
                                                .font16MainRoseNormal,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const HorizontalSpace(width: 10),
                                    if (optionsOffValue.isNullOrEmpty())
                                      const SizedBox.shrink()
                                    else if (!optionsOffValue![
                                            options.indexOf(option)]
                                        .isNullOrEmpty())
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7.sp, vertical: 6.sp),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.mainRose,
                                          borderRadius:
                                              BorderRadius.circular(16.sp),
                                        ),
                                        child: Text(
                                          "${optionsOffValue![options.indexOf(option)]}% $offText",
                                          style:
                                              TextStylesInter.font10WhiteBold,
                                        ),
                                      ),
                                  ],
                                ),
                                if (!deliveries.isNullOrEmpty())
                                  Text(
                                    deliveries![options.indexOf(option)],
                                    style:
                                        TextStylesInter.font11MainRoseRegular,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                          const HorizontalSpace(width: 10),
                          if (!prices.isNullOrEmpty())
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "SAR 159",
                                        style: TextStylesInter
                                            .font10GreyRegularLineThrough,
                                      ),
                                      const HorizontalSpace(width: 4),
                                      Text(
                                        prices![options.indexOf(option)],
                                        style:
                                            TextStylesInter.font16MainRoseBold,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    perDeliveryText,
                                    style:
                                        TextStylesInter.font11MainRoseRegular,
                                  ),
                                ],
                              ),
                            ),
                          if (option == selectOtherDateText)
                            IconButton(
                              onPressed: () async {
                                cubit.setSubscriptionDuration(option);
                              },
                              icon: const Icon(
                                Icons.calendar_today_outlined,
                                color: ColorsManager.mainRose,
                              ),
                            ),
                        ],
                      ),
                    ),
                    value: option,
                    groupValue: cubit.subscriptionDuration,
                    onChanged: (value) async {
                      cubit.setSubscriptionDuration(value!);
                    },
                    activeColor: ColorsManager.mainRose,
                    overlayColor:
                        WidgetStateProperty.all(ColorsManager.mainRose),
                    splashRadius: 10.0.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
