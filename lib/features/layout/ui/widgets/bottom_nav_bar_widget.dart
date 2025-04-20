import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../../../core/assets/assets.dart';
import '../../../cart/logic/getCart/cubit/get_cart_cubit.dart';
import '../../../cart/logic/getCart/cubit/get_cart_state.dart';
import '../../logic/cubit/layout_cubit.dart';
import '../../logic/cubit/layout_state.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: ColorsManager.offWhite,
            boxShadow: [
              BoxShadow(
                color: ColorsManager.black.withAlpha(25),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  Assets.of(context).svgs.home_svg,
                  context.el.bottomNavHome,
                  0,
                  context,
                  height: 14.0.h,
                ),
                _buildNavItem(
                  Assets.of(context).svgs.explore_svg,
                  context.el.bottomNavExplore,
                  1,
                  context,
                  height: 14.0.h,
                ),
                BlocBuilder<GetCartCubit, GetCartState>(
                  builder: (context, state) {
                    return context.read<GetCartCubit>().cartItems > 0
                        ? Badge.count(
                            count: context.read<GetCartCubit>().cartItems,
                            backgroundColor: ColorsManager.mainRose,

                            ///TODO: Fix the offset with localization in arabic
                            offset: const Offset(10, -10.0),
                            child: _buildNavItem(
                              Assets.of(context).svgs.cart_svg,
                              context.el.bottomNavCart,
                              2,
                              context,
                              height: 14.0.h,
                            ),
                          )
                        : _buildNavItem(
                            Assets.of(context).svgs.cart_svg,
                            context.el.bottomNavCart,
                            2,
                            context,
                            height: 14.0.h,
                          );
                  },
                ),
                _buildNavItem(
                  Assets.of(context).svgs.profile_svg,
                  context.el.bottomNavMyAccount,
                  3,
                  context,
                  height: 14.0.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      String icon, String label, int index, BuildContext context,
      {double height = 31}) {
    final currentIndex = context.watch<LayoutCubit>().currentIndex;
    return InkWell(
      onTap: () {
        context.read<LayoutCubit>().changeIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              currentIndex == index
                  ? ColorsManager.mainRose
                  : ColorsManager.grey,
              BlendMode.srcIn,
            ),
            height: height,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: currentIndex == index
                  ? ColorsManager.mainRose
                  : ColorsManager.grey,
              fontWeight:
                  currentIndex == index ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
