import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wardaya/features/authentication/profile/data/repos/profile_repo.dart';
import 'package:wardaya/features/authentication/profile/logic/cubit/profile_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';

import '../../features/authentication/apis/auth_service.dart';
import '../../features/authentication/create_account/data/repos/create_account_repo.dart';
import '../../features/authentication/create_account/logic/cubit/register_cubit.dart';
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/login/logic/cubit/login_cubit.dart';
import '../../features/layout/logic/cubit/layout_cubit.dart';
import '../blocs/general/cubit/general_cubit.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & Services
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(dio));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepo(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));

  getIt.registerFactory<GeneralCubit>(() => GeneralCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  // getIt.registerFactory<NetZeroCubit>(() => NetZeroCubit());
  // getIt.registerFactory<PaginationCubit>(() => PaginationCubit());

  // home
  // getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
}
