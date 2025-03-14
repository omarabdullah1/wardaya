import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();

  await setupGetIt();
  String token =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  isLoggedInUser = token.isNullOrEmpty() ? false : true;
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  log('message From Production');
  log(token);
  log(isLoggedInUser.toString());
  runApp(
    EasyLocalization(
      path: Constants.i18nPath,
      supportedLocales: const [
        Locale(Constants.enLang),
        Locale(Constants.arLang)
      ],
      child: WardayaApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
