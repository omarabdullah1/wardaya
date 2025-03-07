import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../../../core/blocs/general/cubit/general_cubit.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/routing/router_imports.dart';
import '../../logic/cubit/search_state.dart';
import 'filter_chips_row.dart';
import 'product_count_view.dart';
import 'product_view.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is Initial ||
          current is Success ||
          current is Error ||
          current is Loading ||
          current is SetIsGridView ||
          current is ApplyFilters ||
          current is SetTempFilters ||
          current is SetTempFiltersTypeValue,
      builder: (context, state) {
        // final cubit = context.read<SearchCubit>();
        if (state is Initial) {
          return _buildInitial(context);
        } else {
          return _buildBody();
        }
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 25.0.h),
          child: const Column(
            children: [
              FilterChipsRow(),
              Divider(color: ColorsManager.lightGrey, thickness: 1.0),
              ProductCountAndView(),
              Expanded(
                child: ProductView(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                context.read<SearchCubit>().emitSearchStates();
              },
              style: ElevatedButton.styleFrom(
                alignment: AlignmentDirectional.center,
                backgroundColor: ColorsManager.mainRose,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.read<GeneralCubit>().lang ==
                          Constants.arLang
                      ? [
                          Text(
                            context.el.searchButton,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.search, color: Colors.white),
                        ]
                      : [
                          const Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Text(
                            context.el.searchButton,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
