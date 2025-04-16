import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../logic/cubit/search_state.dart';

class ProductCountAndView extends StatelessWidget {
  const ProductCountAndView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) {
        // Only rebuild when the product count changes or view mode changes
        return current is Success || current is SetIsGridView;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${cubit.filteredProducts.length} products',
                style: GoogleFonts.inter(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.mainRose,
                ),
              ),
              _buildViewModeSelector(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildViewModeSelector(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightGrey,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
        child: Row(
          children: [
            _buildViewModeButton(
              context: context,
              svgPath: Assets.of(context).svgs.grid_svg,
              isActive: cubit.isGridView,
              onTap: () => cubit.setIsGridView(true),
            ),
            SizedBox(width: 15.0.w),
            _buildViewModeButton(
              context: context,
              svgPath: Assets.of(context).svgs.tile_svg,
              isActive: !cubit.isGridView,
              onTap: () => cubit.setIsGridView(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewModeButton({
    required BuildContext context,
    required String svgPath,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? ColorsManager.white : ColorsManager.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 3.0.h),
        child: SvgPicture.asset(
          svgPath,
          colorFilter: ColorFilter.mode(
            isActive
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
