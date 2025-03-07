import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../../../core/routing/router_imports.dart';
import '../../logic/cubit/search_state.dart';

class ProductCountAndView extends StatelessWidget {
  const ProductCountAndView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        final String showProductsNumberText =
            'Showing ${cubit.filteredProducts.length} products'; // Replace with localization
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showProductsNumberText,
                style: GoogleFonts.inter(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.mainRose,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrey,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.0.h),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => cubit.setIsGridView(true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: cubit.isGridView
                                ? ColorsManager.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0.w, vertical: 6.0.h),
                          child: SvgPicture.asset(
                            Assets.of(context).svgs.grid_svg,
                            colorFilter: ColorFilter.mode(
                              cubit.isGridView
                                  ? ColorsManager.mainRose
                                  : ColorsManager.mainRose.withAlpha(128),
                              BlendMode.srcIn,
                            ),
                            height: 14.0.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0.w),
                      InkWell(
                        onTap: () => cubit.setIsGridView(false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !cubit.isGridView
                                ? ColorsManager.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0.w, vertical: 6.0.h),
                          child: SvgPicture.asset(
                            Assets.of(context).svgs.tile_svg,
                            colorFilter: ColorFilter.mode(
                              !cubit.isGridView
                                  ? ColorsManager.mainRose
                                  : ColorsManager.mainRose.withAlpha(128),
                              BlendMode.srcIn,
                            ),
                            height: 14.0.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
