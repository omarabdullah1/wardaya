import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/home/data/models/home_delivery_areas_response.dart';

class CitySelectionBottomSheet extends StatelessWidget {
  final Function(City) onCitySelected;
  final String? currentCityId;
  final List<DeliveryArea> deliveryAreas;

  const CitySelectionBottomSheet({
    super.key,
    required this.onCitySelected,
    required this.deliveryAreas,
    this.currentCityId,
  });

  @override
  Widget build(BuildContext context) {
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
                    "Send your gift to...",
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
              "Select City",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // City List - Expanded to take available space
          Flexible(
            child: _buildAllCountriesList(context),
          ),

          // Bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }

  Widget _buildAllCountriesList(BuildContext context) {
    if (deliveryAreas.isEmpty) {
      return Center(
        child: Text(
          "No delivery areas available",
          style: TextStylesInter.font15DarkGreyRegular,
        ),
      );
    }

    return ListView.builder(
      key: const PageStorageKey<String>('country_list'),
      padding: EdgeInsets.zero,
      itemCount: deliveryAreas.length,
      itemBuilder: (context, index) {
        final area = deliveryAreas[index];
        if (area.cities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          key: ValueKey('country-${area.country}-$index'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Text(
                area.country,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: ColorsManager.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListView.builder(
              key: ValueKey('cities-${area.country}-$index'),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: area.cities.length,
              itemBuilder: (context, cityIndex) {
                final city = area.cities[cityIndex];
                final isSelected = currentCityId == city.id;

                return Material(
                  key: ValueKey('city-${city.id}'),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onCitySelected(city);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 24.w),
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
                                  "Delivery: ${city.deliveryPrice} ${city.currency ?? area.currency}",
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
            // Add a divider after each country except the last one
            if (index < deliveryAreas.length - 1)
              Divider(
                color: Colors.grey.shade200,
                height: 1,
                thickness: 1,
                indent: 24.w,
                endIndent: 24.w,
              ),
          ],
        );
      },
    );
  }

  static Future<void> show(
    BuildContext context, {
    required Function(City) onCitySelected,
    required List<DeliveryArea> deliveryAreas,
    String? currentCityId,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext bottomSheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.3,
          maxChildSize: 0.85,
          expand: false,
          builder: (_, scrollController) {
            return CitySelectionBottomSheet(
              onCitySelected: (City city) {
                onCitySelected(city);
                if (bottomSheetContext.mounted) {
                  Navigator.of(bottomSheetContext).pop();
                }
              },
              deliveryAreas: deliveryAreas,
              currentCityId: currentCityId,
            );
          },
        );
      },
    );
  }
}
