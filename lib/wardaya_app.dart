import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/constants.dart';
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
        ));
  }
}
