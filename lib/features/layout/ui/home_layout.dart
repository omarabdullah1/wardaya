import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/explore/ui/explore_screen.dart';
import 'package:wardaya/features/home/ui/home_screen.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/colors.dart';

import '../../cart/ui/cart_screen.dart';
import '../../profile/ui/profile_screen.dart';
import '../logic/cubit/layout_cubit.dart';
import '../logic/cubit/layout_state.dart';
import 'widgets/bottom_nav_bar_widget.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final index = context.watch<LayoutCubit>().currentIndex;
        switch (index) {
          default:
            return Scaffold(
              backgroundColor: ColorsManager.offWhite,
              body: Builder(
                builder: (context) {
                  switch (index) {
                    case 0:
                      return const HomeScreen();
                    case 1:
                      return const ExploreScreen();
                    case 2:
                      return const CartScreen();
                    case 3:
                      return BlocProvider(
                        create: (context) =>
                            getIt<ProfileCubit>()..getProfile(context),
                        child: const ProfileScreen(),
                      );
                    default:
                      return const HomeScreen();
                  }
                },
              ),
              bottomNavigationBar: const BottomNavBarWidget(),
            );
        }
      },
    );
  }
}
