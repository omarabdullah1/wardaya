import 'package:wardaya/features/search/data/models/search_response.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import 'router_imports.dart';

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
          screen: BlocProvider(
            create: (context) => getIt<SearchCubit>(),
            child: const SearchScreen(),
          ),
        );
      case Routes.momentsScreen:
        if (arguments is Map<String, dynamic>) {
          final cubit = arguments['cubit'] as CartCubit?;

          return _buildRoute(
            screen: BlocProvider.value(
              value: cubit ?? getIt<CartCubit>(),
              child: const MomentsScreen(),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.momentsScreen}");
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
        if (arguments is Map<String, dynamic>) {
          final cubit = arguments['cubit'] as CartCubit?;
          final extraArgs = arguments['extraArgs'] as String?;
          return _buildRoute(
            screen: BlocProvider.value(
              value: cubit ?? getIt<CartCubit>(),
              child: CategoryScreen(
                momentTitle: extraArgs ?? "",
              ),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }
      case Routes.productDetailsScreen:
        if (arguments is Map<String, dynamic>) {
          final extraArgs = arguments['extraArgs'] as Product;
          return _buildRoute(
            screen: ProductDetailsScreen(
              product: extraArgs,
            ),
          );
        } else {
          throw ArgumentError(
              "Invalid arguments for ${Routes.productDetailsScreen}");
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
            value: cubit!,
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
