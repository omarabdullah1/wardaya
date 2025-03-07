import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../logic/cubit/search_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  void initState() {
    super.initState();
    context
        .read<SearchCubit>()
        .setTempFilter(Map.from(context.read<SearchCubit>().selectedFilters));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      expand: false,
      builder: (context, scrollController) {
        return BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                color: ColorsManager.lighterGrey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          _buildFilterSection('Category', 'category', [
                            'All',
                            'Cakes',
                            'Flowers',
                            'Sweets & Chocolate',
                            'Jewelry',
                            'Perfumes',
                            'Vouchers',
                          ]),
                          _buildFilterSection('Occasion', 'occasion', [
                            'All',
                            'Birthday',
                            'Anniversary',
                            'General',
                          ]),
                          _buildFilterSection('Recipient', 'recipient', [
                            'All',
                            'Adult',
                            'Partner',
                            'Child',
                            'Parent',
                            'Friend',
                            'Any',
                          ]),
                          _buildFilterSection('Color', 'color', [
                            'All',
                            'Red',
                            'Brown',
                            'Multi',
                            'White',
                            'Gold',
                            'Silver',
                            'None',
                          ]),
                        ],
                      ),
                    ),
                  ),
                  _buildApplyButton(context),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Material(
      elevation: 1.0,
      shadowColor: ColorsManager.grey,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Filters',
                      style: GoogleFonts.ebGaramond(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.lighterGrey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
      String title, String filterType, List<String> options) {
    final cubit = context.read<SearchCubit>();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          iconColor: ColorsManager.mainRose,
          collapsedIconColor: ColorsManager.mainRose,
          backgroundColor: ColorsManager.white,
          title: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.mainRose,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: options
              .map((option) => RadioListTile<String>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    fillColor: WidgetStateProperty.all(ColorsManager.mainRose),
                    title: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.normal,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                    value: option,
                    groupValue: cubit.tempFilters[filterType],
                    onChanged: (value) {
                      setState(() {
                        if (value == "All") {
                          cubit.setTempFilterTypeValue(filterType, null);
                        } else {
                          cubit.setTempFilterTypeValue(filterType, value);
                        }
                      });
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    final filteredCount =
        _calculateFilteredCount(context.read<SearchCubit>().originalProducts);
    final String showFilteredNumberText =
        'Showing $filteredCount products'; // Replace with localization
    final cubit = context.read<SearchCubit>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<SearchCubit>().applyFilters(cubit.tempFilters);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.mainRose,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: GoogleFonts.inter(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Center(child: Text(showFilteredNumberText)),
      ),
    );
  }

  int _calculateFilteredCount(List<Product> products) {
    return products.where((product) {
      final cubit = context.read<SearchCubit>();

      bool categoryMatch = cubit.tempFilters["category"] == null ||
          product.subCategories
              .any((cat) => cat.name == cubit.tempFilters["category"]);
      bool occasionMatch = cubit.tempFilters["occasion"] == null ||
          product.occasions
              .any((occ) => occ.name == cubit.tempFilters["occasion"]);
      bool recipientMatch = cubit.tempFilters["recipient"] == null ||
          product.recipients
              .any((rec) => rec.name == cubit.tempFilters["recipient"]);
      bool colorMatch = cubit.tempFilters["color"] == null ||
          product.colors.any((col) => col.name == cubit.tempFilters["color"]);

      return categoryMatch && occasionMatch && recipientMatch && colorMatch;
    }).length;
  }
}
