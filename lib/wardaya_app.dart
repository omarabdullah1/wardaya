import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/di/dependency_injection.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import 'core/blocs/general/cubit/general_state.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/colors.dart';

class WardayaApp extends StatelessWidget {
  final AppRouter appRouter;
  const WardayaApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GeneralCubit>()..loadLanguage(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchCubit>(),
        ),
      ],
      child: BlocBuilder<GeneralCubit, GeneralState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 667), //design size of the screen
            minTextAdapt: true,
            child: MaterialApp(
              title: 'Wardaya',
              theme: ThemeData(
                primaryColor: ColorsManager.mainRose,
                colorScheme: const ColorScheme.light(
                  primary: ColorsManager.mainRose,
                  secondary: ColorsManager.white,
                ),
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashScreen,
              onGenerateRoute: appRouter.generateRoute,
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              locale: context.read<GeneralCubit>().local,
            ),
          );
        },
      ),
    );
  }
}
