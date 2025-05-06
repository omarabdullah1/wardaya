import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../../../../core/theming/colors.dart';
import '../../logic/cubit/search_cubit.dart';
import '../../logic/cubit/search_state.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the device is an iPad (shortestSide >= 600)
    final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;
    final double factor = isIpad ? 1.5 : 1.0;

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * factor.h + 30.h),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            margin: EdgeInsets.only(
                top: context.pOH(5).h), // Padding around the content
            color: Colors
                .transparent, // Optional: You can add a background color here if needed.
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorsManager.mainRose,
                    size: 18.0.h,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Material(
                      elevation: 2.8,
                      borderRadius: BorderRadius.circular(30.0),
                      child: SizedBox(
                        height: 60.h,
                        child: CupertinoSearchTextField(
                          placeholder: context.el.searchPlaceholder,
                          controller: cubit.searchController,
                          style: TextStylesInter.font13GreyRegular,
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: ColorsManager.mainRose,
                            size: 20.r,
                          ),
                          itemSize: 24,
                          itemColor: ColorsManager.black,
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              cubit.emitSearchStates(search: value);
                            }
                          },
                          onChanged: (value) {
                            // Trigger search on each change if needed
                            // Uncommenting this would create a live search experience
                            // if (value.isNotEmpty) {
                            //   cubit.emitSearchStates(search: value);
                            // }
                          },
                          onSuffixTap: () {
                            cubit.searchController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const HorizontalSpace(width: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize {
    // Get the current platform width to determine device type
    final double shortestSide = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.shortestSide /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    // Use the shortestSide to determine if it's an iPad (>= 600) or other device
    final bool isIpad = shortestSide >= 600;
    final double factor = isIpad ? 1.5 : 0.5;

    return Size.fromHeight(kToolbarHeight * factor.h);
  }
}
