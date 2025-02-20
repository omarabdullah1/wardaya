import 'package:flutter/material.dart';
import '../../../core/assets/assets.dart';
import '../../../core/widgets/animated_splash_screen.dart' as animated_splash;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/constants.dart';
import '../../authentication/login/logic/cubit/login_cubit.dart';
import '../../authentication/login/ui/login_screen.dart';
import '../../cart/logic/cubit/cart_cubit.dart';
import '../../layout/logic/cubit/layout_cubit.dart';
import '../../layout/ui/home_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return animated_splash.AnimatedSplash(
      type: animated_splash.Transition.scale,
      navigator: navigationRemoveUntillScreen(isLoggedInUser),
      curve: Curves.elasticInOut,
      durationInSeconds: 4,
      backgroundColor: ColorsManager.mainRose,
      child: Image.asset(
        Assets.of(context).images.logo.Wardaya_Application_splash_gif,
      ),
    );
  }

  Widget navigationRemoveUntillScreen(bool isLoggedInUser) {
    if (isLoggedInUser) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<CartCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LayoutCubit>(),
          ),
        ],
        child: const HomeLayout(),
      );
    } else {
      return BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const SignInScreen(),
      );
    }
  }
}
