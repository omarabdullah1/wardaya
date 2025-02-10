import 'package:get_it/get_it.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';

import '../../features/authentication/logic/cubit/login_cubit.dart';
import '../../features/layout/logic/cubit/layout_cubit.dart';
import '../blocs/general/cubit/general_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & Services
  // Dio dio = DioFactory.getDio();
  // getIt.registerLazySingleton<LoginService>(() => LoginService(dio));
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<GeneralCubit>(() => GeneralCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(/*getIt()*/));

  getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  // getIt.registerFactory<NetZeroCubit>(() => NetZeroCubit());
  // getIt.registerFactory<PaginationCubit>(() => PaginationCubit());

  // home
  // getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
}
