import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/router_imports.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/cubit/search_cubit.dart';
import '../../logic/cubit/search_state.dart';

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        final categories = cubit.originalProducts
            .expand((product) => product.subCategories)
            .map((cat) => cat.name)
            .toSet()
            .toList();

        final occasions = cubit.originalProducts
            .expand((product) => product.occasions)
            .map((occ) => occ.name)
            .toSet()
            .toList();

        return SizedBox(
          height: 50.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip(
                "All",
                "All",
                context: context,
              ),
              ...categories.map((category) => _buildFilterChip(
                    category,
                    "category",
                    context: context,
                  )),
              ...occasions.map((occasion) => _buildFilterChip(
                    occasion,
                    "occasion",
                    context: context,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String filterType,
      {required BuildContext context}) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: ChoiceChip(
            backgroundColor: ColorsManager.white,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: ColorsManager.transparent),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            elevation: 4,
            avatar: Padding(
              padding: EdgeInsetsDirectional.only(end: 1.0.w),
              child: Container(
                height: 35.0.h,
                decoration: const BoxDecoration(
                  color: ColorsManager.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            showCheckmark: false,
            label: Text(
              label,
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 2.h,
            ),
            labelPadding: EdgeInsetsDirectional.only(start: 12.0.w),
            selected: filterType == "All"
                ? cubit.selectedFilters
                    .isEmpty // "All" is selected when no filters are active
                : cubit.selectedFilters[filterType] ==
                    label, // Other filters are selected when they match
            onSelected: (selected) {
              if (filterType == "All") {
                // When "All" is selected, clear all filters
                cubit.applyFilters({});
              } else {
                // For other filters
                final updatedFilters =
                    Map<String, String?>.from(cubit.selectedFilters);

                if (selected) {
                  // When selecting a filter, clear "All" and apply the new filter
                  updatedFilters[filterType] = label;
                } else {
                  // When deselecting a filter, remove it
                  updatedFilters.remove(filterType);
                }

                // If no filters are selected after update, automatically select "All"
                if (updatedFilters.isEmpty) {
                  cubit.applyFilters({});
                } else {
                  cubit.applyFilters(updatedFilters);
                }
              }
            },
          ),
        );
      },
    );
  }
}
