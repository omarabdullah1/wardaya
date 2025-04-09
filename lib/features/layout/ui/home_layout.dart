import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_cubit.dart';
import 'package:wardaya/features/home/logic/brands/brands_cubit.dart';
import 'package:wardaya/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/explore/ui/explore_screen.dart';
import 'package:wardaya/features/home/ui/home_screen.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/colors.dart';

import '../../cart/ui/cart_screen.dart';
import '../../home/logic/categories/categories_cubit.dart';
import '../../home/logic/delivery_areas/delivery_areas_cubit.dart';
import '../../home/logic/gallery/gallery_cubit.dart';
import '../../home/logic/occassions/occassions_cubit.dart';
import '../../home/logic/recipients/recipients_cubit.dart';
import '../../profile/ui/profile_screen.dart';
import '../logic/cubit/layout_cubit.dart';
import '../logic/cubit/layout_state.dart';
import 'widgets/bottom_nav_bar_widget.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

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
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<GalleryCubit>()..getHomeGallery(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<OccassionsCubit>()..getHomeOccassions(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<CategoriesCubit>()..getCategories(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<BrandsCubit>()..getBrands(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<RecipientsCubit>()..getRecipients(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<DeliveryAreasCubit>()..getDeliveryAreas(),
                          ),
                        ],
                        child: const HomeScreen(),
                      );
                    case 1:
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<BrandsCubit>()..getBrands(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<ExploreCubit>()..getMenuItems(),
                          ),
                        ],
                        child: const ExploreScreen(),
                      );
                    case 2:
                      return const CartScreen();
                    case 3:
                      return BlocProvider(
                        create: (context) =>
                            getIt<ProfileCubit>()..getProfile(context),
                        child: const ProfileScreen(),
                      );
                    default:
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                getIt<GalleryCubit>()..getHomeGallery(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<OccassionsCubit>()..getHomeOccassions(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<CategoriesCubit>()..getCategories(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<BrandsCubit>()..getBrands(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<RecipientsCubit>()..getRecipients(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                getIt<DeliveryAreasCubit>()..getDeliveryAreas(),
                          ),
                        ],
                        child: const HomeScreen(),
                      );
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
