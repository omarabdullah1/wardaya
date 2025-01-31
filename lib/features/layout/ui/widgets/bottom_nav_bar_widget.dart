import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/theming/colors.dart';

import '../../../../core/theming/wardaya_icons_icons.dart';
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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(WardayaIcons.home, 'HOME', 0, context),
                _buildNavItem(CupertinoIcons.search, 'EXPLORE', 1, context),
                _buildNavItem(WardayaIcons.cart, 'CART', 2, context),
                _buildNavItem(WardayaIcons.profile, 'MY ACCOUNT', 3, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final currentIndex = context.watch<LayoutCubit>().currentIndex;
    return InkWell(
      onTap: () {
        context.read<LayoutCubit>().changeIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: currentIndex == index
                ? ColorsManager.mainRose
                : ColorsManager.grey,
            size: icon == CupertinoIcons.search ? 32 : 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: currentIndex == index
                  ? ColorsManager.mainRose
                  : ColorsManager.grey,
              fontWeight:
                  currentIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
