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
                      EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
                  child: Row(
                    children: [
                      _buildViewModeSelector(
                        context: context,
                        svgPath: Assets.of(context).svgs.grid_svg,
                        onTap: () => cubit.setIsGridView(true),
                        isGridView: cubit.isGridView,
                      ),
                      SizedBox(width: 15.0.w),
                      _buildViewModeSelector(
                        context: context,
                        svgPath: Assets.of(context).svgs.tile_svg,
                        onTap: () => cubit.setIsGridView(false),
                        isGridView: !cubit.isGridView,
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

  Widget _buildViewModeSelector({
    required BuildContext context,
    required String svgPath,
    required Function onTap,
    required bool isGridView,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: isGridView ? ColorsManager.white : ColorsManager.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 3.0.h),
        child: SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(
            isGridView
                ? ColorsManager.mainRose
                : ColorsManager.mainRose.withAlpha(128),
            BlendMode.srcIn,
          ),
          height: 14.0.h,
        ),
      ),
    );
  }
}
