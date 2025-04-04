import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wardaya/features/home/data/apis/home_service.dart';
import 'package:wardaya/features/home/data/repos/home_repo.dart';
import 'package:wardaya/features/profile/data/repos/profile_repo.dart';
import 'package:wardaya/features/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/search/data/apis/search_service.dart';
import 'package:wardaya/features/search/data/repos/search_repo.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';
import 'package:wardaya/features/subscriptions/data/apis/subscription_service.dart';
import 'package:wardaya/features/subscriptions/data/repos/subscription_repo.dart';
import 'package:wardaya/features/subscriptions/logic/cubit/subscription_cubit.dart';

import '../../features/authentication/apis/auth_service.dart';
import '../../features/authentication/create_account/data/repos/create_account_repo.dart';
import '../../features/authentication/create_account/logic/cubit/register_cubit.dart';
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/login/logic/cubit/login_cubit.dart';
import '../../features/home/logic/gallery/gallery_cubit.dart';
import '../../features/layout/logic/cubit/layout_cubit.dart';
import '../blocs/general/cubit/general_cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /************************* */
  /* ***** Dio & Services ****
  /************************ */
  */

  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(dio));
  getIt.registerLazySingleton<SearchService>(() => SearchService(dio));
  getIt.registerLazySingleton<SubscriptionService>(
      () => SubscriptionService(dio));
  getIt.registerLazySingleton<HomeService>(() => HomeService(dio));

  /************************* */
  /* ******** REPOS *********
  /************************ */
  */

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepo(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()));
  getIt
      .registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));

  /************************* */
  /* ******** CUBIT *********
  /************************ */
  */

  getIt.registerFactory<GeneralCubit>(() => GeneralCubit());

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<SubscriptionCubit>(() => SubscriptionCubit(getIt()));
  getIt.registerFactory<GalleryCubit>(() => GalleryCubit(getIt()));

  getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
}
