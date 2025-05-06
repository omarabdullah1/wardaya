import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/home/data/models/home_delivery_areas_response.dart';

class CitySelectionBottomSheet extends StatelessWidget {
  final List<DeliveryArea> deliveryAreas;
  final String? currentCityId;

  const CitySelectionBottomSheet({
    super.key,
    required this.deliveryAreas,
    this.currentCityId,
  });

  // Get only Saudi Arabia cities and sort them
  List<City> _getSortedSaudiCities(BuildContext context) {
    final saudiArea = deliveryAreas.firstWhere(
      (area) => area.country == context.el.sAfilter,
      orElse: () => DeliveryArea(
        id: "",
        country: "Saudi Arabia",
        currency: "SAR",
        language: "Arabic",
        cities: [],
      ),
    );

    final cities = List<City>.from(saudiArea.cities);
    cities.sort((a, b) => a.name.compareTo(b.name));
    return cities;
  }

  static Future<City?> show(
    BuildContext context, {
    required List<DeliveryArea> deliveryAreas,
    String? currentCityId,
  }) {
    return showModalBottomSheet<City>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: true,
      enableDrag: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext bottomSheetContext) {
        return SizedBox(
          width: MediaQuery.of(bottomSheetContext).size.width,
          child: DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.3,
            maxChildSize: 0.85,
            expand: false,
            builder: (_, scrollController) {
              return CitySelectionBottomSheet(
                deliveryAreas: deliveryAreas,
                currentCityId: currentCityId,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedCities = _getSortedSaudiCities(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar for dragging
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 60.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.el.sendYourGiftTo,
                    style: GoogleFonts.ebGaramond(
                      fontSize: 32.sp,
                      color: ColorsManager.mainRose,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    child: Icon(
                      Icons.close,
                      color: ColorsManager.mainRose,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 16.h),
            child: Text(
              context.el.selectCityTitle,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          if (sortedCities.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "لا توجد مدن متاحة حالياً",
                  style: TextStylesInter.font15DarkGreyRegular,
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: sortedCities.length,
                itemBuilder: (context, index) {
                  final city = sortedCities[index];
                  final isSelected = currentCityId == city.id;

                  return Material(
                    key: ValueKey('city-${city.id}'),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context, city),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 24.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  city.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: isSelected
                                        ? ColorsManager.mainRose
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                  ),
                                ),
                                if (city.deliveryPrice > 0)
                                  Text(
                                    "رسوم التوصيل: ${city.deliveryPrice} ريال",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                            if (isSelected)
                              Container(
                                width: 24.w,
                                height: 24.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsManager.mainRose,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }
}
