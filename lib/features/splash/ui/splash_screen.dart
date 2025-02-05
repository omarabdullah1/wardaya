import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart'
    as animated_splash;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../authentication/logic/cubit/login_cubit.dart';
import '../../authentication/ui/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return animated_splash.AnimatedSplash(
      type: animated_splash.Transition.scale,
      navigator: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const SignInScreen(),
      ),
      curve: Curves.elasticInOut,
      durationInSeconds: 4,
      backgroundColor: ColorsManager.mainRose,
      child: Image.asset(
        'assets/images/logo/Wardaya_Application_splash.gif',
      ),
    );
  }
}
