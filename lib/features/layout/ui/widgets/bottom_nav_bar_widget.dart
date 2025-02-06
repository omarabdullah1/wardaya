import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import '../../../cart/logic/cubit/cart_state.dart';
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
                color: Colors.black.withAlpha(25),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('assets/svgs/home.svg', 'HOME', 0, context,
                    height: 14.0.h),
                _buildNavItem('assets/svgs/explore.svg', 'EXPLORE', 1, context,
                    height: 14.0.h),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return context.read<CartCubit>().cartItems > 0
                        ? Badge.count(
                            count: context.read<CartCubit>().cartItems,
                            backgroundColor: ColorsManager.mainRose,
                            offset: const Offset(10, -10.0),
                            child: _buildNavItem(
                                'assets/svgs/cart.svg', 'CART', 2, context,
                                height: 14.0.h),
                          )
                        : _buildNavItem(
                            'assets/svgs/cart.svg', 'CART', 2, context,
                            height: 14.0.h);
                  },
                ),
                _buildNavItem(
                    'assets/svgs/profile.svg', 'MY ACCOUNT', 3, context,
                    height: 14.0.h),
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
