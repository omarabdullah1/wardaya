import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/routing/app_router.dart';
import 'wardaya_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  String token =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  isLoggedInUser = token.isNullOrEmpty() ? false : true;
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  log('message From Production');
  runApp(
    WardayaApp(
      appRouter: AppRouter(),
    ),
  );
}
