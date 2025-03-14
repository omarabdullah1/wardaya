import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/features/authentication/create_account/logic/cubit/register_cubit.dart';
import 'package:wardaya/features/authentication/create_account/ui/create_account.dart';
import 'package:wardaya/features/authentication/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/cart/ui/customize_gift_card_screen.dart';
import 'package:wardaya/features/category/ui/category_screen.dart';
import 'package:wardaya/features/explore/ui/recipients_screen.dart';
import 'package:wardaya/features/layout/logic/cubit/layout_cubit.dart';
import 'package:wardaya/features/authentication/profile/ui/profile_screen.dart';
import 'package:wardaya/features/splash/ui/splash_screen.dart';
import '../../features/authentication/forget_password/ui/forget_password.dart';
import '../../features/authentication/login/logic/cubit/login_cubit.dart';
import '../../features/authentication/login/ui/login_screen.dart';
import '../../features/authentication/profile/ui/edit_profile_screen.dart';
import '../../features/cart/ui/record_screen.dart';
import '../../features/explore/ui/flowers_gifts.dart';
import '../../features/explore/ui/flowers_planets.dart';
import '../../features/explore/ui/moments_screen.dart';
import '../../features/layout/ui/home_layout.dart';
import '../../features/product_details/ui/product_details_screen.dart';
import '../../features/authentication/profile/ui/faq_screen.dart';
import '../../features/authentication/profile/ui/tac_screen.dart';
import '../../features/search/ui/search_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return _buildRoute(screen: const SplashScreen());

      case Routes.loginScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const SignInScreen(),
          ),
        );
      case Routes.homeLayout:
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CartCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<LayoutCubit>(),
              ),
            ],
            child: const HomeLayout(),
          ),
        );
      case Routes.searchScreen:
        return _buildRoute(
          screen: const SearchScreen(),
        );
      case Routes.momentsScreen:
        // Ensure arguments is a Map before accessing its keys
        if (arguments is Map<String, dynamic>) {
          final cubit = arguments['cubit'] as CartCubit?;

          return _buildRoute(
            screen: BlocProvider.value(
              value: cubit ??
                  getIt<CartCubit>(), // Use existing Cubit or create a new one
              child: const MomentsScreen(),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }
      case Routes.recipientsScreen:
        return _buildRoute(
          screen: RecipientsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.flowersPlantsScreen:
        return _buildRoute(
          screen: FlowersPlantsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.flowersGiftsScreen:
        return _buildRoute(
          screen: FlowersGiftsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );

      case Routes.categoryScreen:
        // Ensure arguments is a Map before accessing its keys
        if (arguments is Map<String, dynamic>) {
          final cubit = arguments['cubit'] as CartCubit?;
          final extraArgs =
              arguments['extraArgs'] as String?; // Ensure it's a String
          return _buildRoute(
            screen: BlocProvider.value(
              value: cubit ??
                  getIt<CartCubit>(), // Use existing Cubit or create a new one
              child: CategoryScreen(
                momentTitle: extraArgs ?? "", // Handle null values safely
              ),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }
      case Routes.productDetailsScreen:
        // Ensure arguments is a Map before accessing its keys
        if (arguments is Map<String, dynamic>) {
          final cubit = arguments['cubit'] as CartCubit?;
          return _buildRoute(
            screen: BlocProvider.value(
              value: cubit ??
                  getIt<CartCubit>(), // Use existing Cubit or create a new one
              child: const ProductDetailsScreen(),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }
      case Routes.forgetPasswordScreen:
        return _buildRoute(screen: const ForgetPasswordScreen());
      case Routes.createAccountScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const CreateAccountScreen(),
          ),
        );
      case Routes.profileScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getProfile(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.faqScreen:
        return _buildRoute(screen: const FAQScreen());
      case Routes.tacScreen:
        return _buildRoute(screen: const TACScreen());
      case Routes.customizeGiftCardScreen:
        final List args = arguments as List;
        final BuildContext parentContext = args[1] as BuildContext;
        final CartCubit cartCubit = BlocProvider.of<CartCubit>(parentContext);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: cartCubit,
              child: CustomizeGiftCardScreen(
                initialTabIndex: args[0] as int,
                cartContext: parentContext,
              ),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.recordScreen:
        return _buildRoute(screen: const RecordScreen());
      case Routes.editProfileScreen:
        final cubit =
            (arguments as Map<String, dynamic>?)?['cubit'] as ProfileCubit?;
        return _buildRoute(
          screen: BlocProvider<ProfileCubit>.value(
            value: cubit!, // Use passed cubit or create a new one
            child: const EditProfileScreen(),
          ),
        );
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute({required Widget screen}) {
    return MaterialPageRoute(
      builder: (context) => screen,
    );
  }
}
