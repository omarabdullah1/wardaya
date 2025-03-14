import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/search/data/apis/search_api_constants.dart';
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
        final categoriesNames = cubit.originalProducts
            .expand((product) => product.subCategories)
            .map((cat) => cat.name)
            .toSet()
            .toList();

        final occasionsNames = cubit.originalProducts
            .expand((product) => product.occasions)
            .map((occ) => occ.name)
            .toSet()
            .toList();
        // i want a list of occasions and categories images of the names in the lists above
        final categoriesImages = categoriesNames.map((name) {
          return cubit.originalProducts
              .expand((product) => product.subCategories)
              .firstWhere((cat) => cat.name == name)
              .imageUrl;
        }).toList();

        final occasionsImages = occasionsNames.map((name) {
          return cubit.originalProducts
              .expand((product) => product.occasions)
              .firstWhere((occ) => occ.name == name)
              .imageUrl;
        }).toList();
        final categoryPairs = List<MapEntry<String, String>>.from(
          categoriesNames.asMap().entries.map(
                (entry) => MapEntry(entry.value, categoriesImages[entry.key]),
              ),
        );

        final occasionPairs = List<MapEntry<String, String>>.from(
          occasionsNames.asMap().entries.map(
                (entry) => MapEntry(entry.value, occasionsImages[entry.key]),
              ),
        );
        log('cat: $categoryPairs');
        log('occ: $occasionPairs');
        log('categoriesNames: $categoriesNames');
        final allPairs = [
          ...categoryPairs.map((pair) => _buildFilterChip(
                pair.key,
                "category",
                pair.value,
                context: context,
              )),
          ...occasionPairs.map((pair) => _buildFilterChip(
                pair.key,
                "occasion",
                pair.value,
                context: context,
              )),
        ];
        // log(categoriesImages.toString());
        // log(occasionsImages.toString());
        return SizedBox(
          height: 50.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip(
                "All",
                "All",
                '',
                context: context,
              ),
              ...allPairs
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String filterType, String image,
      {required BuildContext context}) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
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
                decoration: BoxDecoration(
                  color: ColorsManager.grey,
                  shape: BoxShape.circle,
                  image: image.isNullOrEmpty()
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            SearchApiConstants.apiBaseUrlForImages + image,
                          ),
                          onError: (exception, stackTrace) =>
                              log(exception.toString()),
                        )
                      : null,
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
                  List catList = cubit.originalProducts
                      .expand((product) => product.subCategories)
                      .map((cat) => cat.name)
                      .toSet()
                      .toList();

                  List occList = cubit.originalProducts
                      .expand((product) => product.occasions)
                      .map((occ) => occ.name)
                      .toSet()
                      .toList();
                  // When selecting a filter, clear "All" and apply the new filter
                  final categoryIds = cubit.originalProducts
                      .expand((product) => product.categories)
                      .map((cat) => cat.id)
                      .toSet()
                      .toList();
                  final occasionIds = cubit.originalProducts
                      .expand((product) => product.occasions)
                      .map((occ) => occ.id)
                      .toSet()
                      .toList();
                  // log(label);
                  // log(catList.toString());
                  // log(catList.indexOf(label).toString());
                  // log(occList.indexOf(label).toString());
                  switch (filterType) {
                    case "category":
                      updatedFilters["category"] =
                          categoryIds[catList.indexOf(label)];
                      break;
                    case "occasion":
                      updatedFilters["occasion"] =
                          occasionIds[occList.indexOf(label)];
                      break;
                  }
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
