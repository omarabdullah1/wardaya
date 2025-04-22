import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/cart/logic/getCart/cubit/get_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/removeCart/cubit/remove_cart_cubit.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_cubit.dart';
import 'package:wardaya/features/home/logic/brands/brands_cubit.dart';
import 'package:wardaya/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/explore/ui/explore_screen.dart';
import 'package:wardaya/features/home/ui/home_screen.dart';
import 'package:wardaya/features/home/logic/new_ideas/new_ideas_cubit.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/colors.dart';

import '../../cart/logic/addToCart/cubit/add_to_cart_cubit.dart';
import '../../cart/logic/giftCards/gift_cards_cubit.dart';
import '../../cart/logic/uploadSignature/upload_signature_cubit.dart';
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
  final Map<String, dynamic>? arguments;
  const HomeLayout({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<GetCartCubit>()..getCart();
        if (arguments != null && arguments!.containsKey('initialIndex')) {
          context.read<LayoutCubit>().changeIndex(arguments!['initialIndex']);
        }
        return cubit;
      },
      child: BlocBuilder<LayoutCubit, LayoutState>(
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
                              create: (context) => getIt<DeliveryAreasCubit>()
                                ..getDeliveryAreas(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<NewIdeasCubit>()..getHomeNewIdeas(),
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
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  getIt<UploadSignatureCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => getIt<AddToCartCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => getIt<RemoveCartCubit>(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<GiftCardsCubit>()..getGiftCards(),
                            ),
                          ],
                          child: const CartScreen(),
                        );
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
                              create: (context) => getIt<DeliveryAreasCubit>()
                                ..getDeliveryAreas(),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  getIt<NewIdeasCubit>()..getHomeNewIdeas(),
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
      ),
    );
  }
}
