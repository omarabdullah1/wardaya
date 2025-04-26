import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/address/data/models/address_response.dart';

class AddressSelectorCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final Function(Address) onSelect;

  const AddressSelectorCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(address),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? ColorsManager.mainRose : Colors.grey[300]!,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        ColorsManager.mainRose.withAlpha((0.2 * 255).toInt()),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              // Circle with map pin icon or first letter of the address title
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: ColorsManager.mainRose.withAlpha((0.1 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: ColorsManager.mainRose,
                    size: 24.w,
                  ),
                ),
              ),
              HorizontalSpace(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.title ?? "My Address",
                      style: TextStylesInter.font14BlackSemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VerticalSpace(height: 4.h),
                    Text(
                      address.recipientAddress,
                      style: TextStylesInter.font12BlackBold.copyWith(
                        color: ColorsManager.grey,
                        fontWeight: FontWeightHelper.regular,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (address.recipientName != null &&
                        address.recipientName!.isNotEmpty) ...[
                      VerticalSpace(height: 4.h),
                      Text(
                        address.recipientName!,
                        style: TextStylesInter.font12BlackBold.copyWith(
                          color: ColorsManager.grey,
                          fontWeight: FontWeightHelper.regular,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                activeColor: ColorsManager.mainRose,
                onChanged: (_) => onSelect(address),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
