import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/data/models/filter_data_response.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../logic/cubit/search_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.filterDataResponse,
  });
  final FilterDataResponse filterDataResponse;
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
        // final cubit = context.read<SearchCubit>();
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
                          widget.filterDataResponse.occasions.isNotEmpty
                              ? _buildFilterSection(
                                  'Occasion',
                                  'occasion',
                                  widget.filterDataResponse.occasions
                                      .map((e) => e.name)
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          widget.filterDataResponse.recipients.isNotEmpty
                              ? _buildFilterSection(
                                  'Recipient',
                                  'recipient',
                                  widget.filterDataResponse.recipients
                                      .map((e) => e.name)
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          widget.filterDataResponse.colors.isNotEmpty
                              ? _buildFilterSection(
                                  'Color',
                                  'color',
                                  widget.filterDataResponse.colors
                                      .map((e) => e.name)
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          widget.filterDataResponse.bundleTypes.isNotEmpty
                              ? _buildFilterSection(
                                  'Bundle Type',
                                  'bundleType',
                                  widget.filterDataResponse.bundleTypes
                                      .map((e) => e.name)
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          // widget.filterDataResponse.priceRanges.isNotEmpty
                          //     ? _buildFilterSection(
                          //         'Price Range',
                          //         'priceRange',
                          //         widget.filterDataResponse.priceRanges
                          //             .map((e) => e.id)
                          //             .toList(),
                          //       )
                          //     : const SizedBox.shrink(),
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
                      context.el.filterTitle,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsManager.lighterGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: ColorsManager.mainRose,
                      size: 20.r,
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
    String filterTitle;
    switch (filterType) {
      case 'occasion':
        filterTitle = context.el.filterOccasion;
        break;
      case 'recipient':
        filterTitle = context.el.filterRecipient;
        break;
      case 'color':
        filterTitle = context.el.filterColor;
        break;
      case 'bundleType':
        filterTitle = context.el.filterBundleType;
        break;
      default:
        filterTitle = title;
    }

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
            filterTitle,
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
                      '$option (${getCount(option, filterType)})',
                      style: GoogleFonts.inter(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.normal,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                    value: option,
                    groupValue: cubit.tempFilters[filterType].isNullOrEmpty()
                        ? null
                        : getOption(cubit.tempFilters[filterType]!, filterType),
                    onChanged: (value) {
                      setState(() {
                        if (value == "All") {
                          cubit.setTempFilterTypeValue(filterType, null);
                        } else {
                          // log(cubit.tempFilters.toString());
                          cubit.setTempFilterTypeValue(
                              filterType, getValue(value!, filterType));
                        }
                      });
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  getValue(String value, String? filterType) {
    // log(value);
    // log(filterType.toString());
    switch (filterType) {
      case 'occasion':
        return widget
            .filterDataResponse
            .occasions[widget.filterDataResponse.occasions
                .map((occ) => occ.name)
                .toList()
                .indexOf(value)]
            .id;
      case 'recipient':
        return widget
            .filterDataResponse
            .recipients[widget.filterDataResponse.recipients
                .map((recipient) => recipient.name)
                .toList()
                .indexOf(value)]
            .id;
      case 'color':
        return widget
            .filterDataResponse
            .colors[widget.filterDataResponse.colors
                .map((color) => color.name)
                .toList()
                .indexOf(value)]
            .id;
      case 'bundleType':
        return widget
            .filterDataResponse
            .bundleTypes[widget.filterDataResponse.bundleTypes
                .map((bundleType) => bundleType.name)
                .toList()
                .indexOf(value)]
            .id;
      case 'priceRange':
        return widget
            .filterDataResponse
            .priceRanges[widget.filterDataResponse.priceRanges
                .map((priceRange) => priceRange.id)
                .toList()
                .indexOf(value)]
            .id;
      default:
        return value;
    }
  }

  getCount(String value, String? filterType) {
    // log(value);
    // log(filterType.toString());
    switch (filterType) {
      case 'occasion':
        return widget
            .filterDataResponse
            .occasions[widget.filterDataResponse.occasions
                .map((occ) => occ.name)
                .toList()
                .indexOf(value)]
            .count;
      case 'recipient':
        return widget
            .filterDataResponse
            .recipients[widget.filterDataResponse.recipients
                .map((recipient) => recipient.name)
                .toList()
                .indexOf(value)]
            .count;
      case 'color':
        return widget
            .filterDataResponse
            .colors[widget.filterDataResponse.colors
                .map((color) => color.name)
                .toList()
                .indexOf(value)]
            .count;
      case 'bundleType':
        return widget
            .filterDataResponse
            .bundleTypes[widget.filterDataResponse.bundleTypes
                .map((bundleType) => bundleType.name)
                .toList()
                .indexOf(value)]
            .count;
      case 'priceRange':
        // log('message');
        return widget
            .filterDataResponse
            .priceRanges[widget.filterDataResponse.priceRanges
                .map((priceRange) => priceRange.id)
                .toList()
                .indexOf(value)]
            .count;
      default:
        return value;
    }
  }

  getOption(String value, String filterType) {
    // log(value);
    // log(filterType.toString());
    switch (filterType) {
      case 'occasion':
        return widget
            .filterDataResponse
            .occasions[widget.filterDataResponse.occasions
                .map((occ) => occ.id)
                .toList()
                .indexOf(value)]
            .name;
      case 'recipient':
        return widget
            .filterDataResponse
            .recipients[widget.filterDataResponse.recipients
                .map((recipient) => recipient.id)
                .toList()
                .indexOf(value)]
            .name;
      case 'color':
        return widget
            .filterDataResponse
            .colors[widget.filterDataResponse.colors
                .map((color) => color.id)
                .toList()
                .indexOf(value)]
            .name;
      case 'bundleType':
        return widget
            .filterDataResponse
            .bundleTypes[widget.filterDataResponse.bundleTypes
                .map((bundleType) => bundleType.id)
                .toList()
                .indexOf(value)]
            .name;
      case 'priceRange':
        return widget
            .filterDataResponse
            .priceRanges[widget.filterDataResponse.priceRanges
                .map((priceRange) => priceRange.id)
                .toList()
                .indexOf(value)]
            .id;
      default:
        return value;
    }
  }

  Widget _buildApplyButton(BuildContext context) {
    final filteredCount =
        _calculateFilteredCount(context.read<SearchCubit>().originalProducts);
    final String showFilteredNumberText =
        '${context.el.showProductsPart1}$filteredCount${context.el.showProductsPart2}';
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
          foregroundColor: ColorsManager.white,
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
              .any((occ) => occ.id == cubit.tempFilters["occasion"]);
      bool recipientMatch = cubit.tempFilters["recipient"] == null ||
          product.recipients
              .any((rec) => rec.id == cubit.tempFilters["recipient"]);
      bool colorMatch = cubit.tempFilters["color"] == null ||
          product.colors.any((col) => col.id == cubit.tempFilters["color"]);
      bool bundleTypeMatch = cubit.tempFilters["bundleType"] == null ||
          product.bundleTypes.any(
              (bundleType) => bundleType.id == cubit.tempFilters["bundleType"]);

      return categoryMatch &&
          occasionMatch &&
          recipientMatch &&
          colorMatch &&
          bundleTypeMatch;
    }).length;
  }
}
