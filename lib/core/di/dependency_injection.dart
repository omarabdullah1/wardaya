import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & Services
  Dio dio = DioFactory.getDio();
  // getIt.registerLazySingleton<LoginService>(() => LoginService(dio));
  // getIt
  //     .registerLazySingleton<GreenShieldService>(() => GreenShieldService(dio));
  //       getIt
  //     .registerLazySingleton<GreenHubService>(() => GreenHubService(dio));
  // getIt.registerLazySingleton<ChatService>(() => ChatService(dio));

  // login
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // green shield
  // getIt.registerLazySingleton<GreenShieldRepo>(() => GreenShieldRepo(getIt()));
  // getIt.registerFactory<GreenShieldCubit>(() => GreenShieldCubit(getIt()));

  // green hub
  // getIt.registerLazySingleton<GreenHubRepo>(() => GreenHubRepo(getIt()));
  // getIt.registerFactory<GreenHubCubit>(() => GreenHubCubit(getIt()));

  // chat
  // getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(getIt()));
  // getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt()));

  // getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  // getIt.registerFactory<NetZeroCubit>(() => NetZeroCubit());
  // getIt.registerFactory<PaginationCubit>(() => PaginationCubit());

  // home
  // getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
}
