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
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return PreferredSize(
          preferredSize: Size.fromHeight(
              kToolbarHeight + 30.h), // Add some extra space for padding
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
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorsManager.mainRose,
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
                        height: 40.h,
                        child: CupertinoSearchTextField(
                          placeholder: context.el.searchPlaceholder,
                          controller: cubit.searchController,
                          style: TextStylesInter.font13GreyRegular,
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            color: ColorsManager.mainRose,
                          ),
                          itemSize: 24,
                          itemColor: ColorsManager.black,
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onSubmitted: (value) {
                            cubit.emitSearchStates();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                horizontalSpace(16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
