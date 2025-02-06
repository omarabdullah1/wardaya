import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/features/authentication/ui/create_account.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/category/ui/category_screen.dart';
import 'package:wardaya/features/explore/ui/recipients_screen.dart';
import 'package:wardaya/features/layout/logic/cubit/layout_cubit.dart';
import 'package:wardaya/features/profile/ui/profile_screen.dart';
import 'package:wardaya/features/splash/ui/splash_screen.dart';
import '../../features/authentication/logic/cubit/login_cubit.dart';
import '../../features/authentication/ui/forget_password.dart';
import '../../features/authentication/ui/login_screen.dart';
import '../../features/explore/ui/flowers_gifts.dart';
import '../../features/explore/ui/flowers_planets.dart';
import '../../features/explore/ui/moments_screen.dart';
import '../../features/layout/ui/home_layout.dart';
import '../../features/product_details/ui/product_details_screen.dart';
import '../../features/profile/ui/faq_screen.dart';
import '../../features/profile/ui/tac_screen.dart';
import '../../features/search/ui/search_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      // case Routes.onBoardingScreen:
      // return MaterialPageRoute(
      //   builder: (_) => const OnboardingScreen(),
      // );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const SignInScreen(),
          ),
        );
      case Routes.homeLayout:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
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
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case Routes.momentsScreen:
        return MaterialPageRoute(
          builder: (_) => MomentsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.recipientsScreen:
        return MaterialPageRoute(
          builder: (_) => RecipientsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.flowersPlantsScreen:
        return MaterialPageRoute(
          builder: (_) => FlowersPlantsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.flowersGiftsScreen:
        return MaterialPageRoute(
          builder: (_) => FlowersGiftsScreen(
            cartContext: (arguments as BuildContext),
          ),
        );
      case Routes.categoryScreen:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(
            arguments: (arguments as List),
          ),
        );
      case Routes.productDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            cartContext: arguments as BuildContext,
          ),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.createAccountScreen:
        return MaterialPageRoute(
          builder: (_) => const CreateAccountScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.faqScreen:
        return MaterialPageRoute(
          builder: (_) => const FAQScreen(),
        );
      case Routes.tacScreen:
        return MaterialPageRoute(
          builder: (_) => const TACScreen(),
        );
      // case Routes.homeLayout:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) =>
      //           getIt<LayoutCubit>()..changeIndex(arguments as int),
      //       child: const HomeLayout(),
      //     ),
      //   );
      // case Routes.profile:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProfileScreen(),
      //   );
      // case Routes.settings:
      //   return MaterialPageRoute(
      //     builder: (_) => const SettingsScreen(),
      //   );
      // case Routes.support:
      //   return MaterialPageRoute(
      //     builder: (_) => const SupportScreen(),
      //   );
      // case Routes.frequentlyAskedQuestions:
      //   return MaterialPageRoute(
      //     builder: (_) => const FrequentlyAskedQuestionsScreen(),
      //   );

      default:
        return null;
    }
  }
}
