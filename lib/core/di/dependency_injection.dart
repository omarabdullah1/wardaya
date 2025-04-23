import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wardaya/features/address/data/api/address_service.dart';
import 'package:wardaya/features/address/data/repos/address_repo.dart';
import 'package:wardaya/features/cart/data/repos/cart_repo.dart';
import 'package:wardaya/features/cart/logic/addToCart/cubit/add_to_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/giftCards/gift_cards_cubit.dart';
import 'package:wardaya/features/cart/logic/removeCart/cubit/remove_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/videoUpload/video_upload_cubit.dart';
import 'package:wardaya/features/explore/data/apis/explore_service.dart';
import 'package:wardaya/features/explore/data/repos/explore_repo.dart';
import 'package:wardaya/features/explore/logic/cubit/explore_cubit.dart';
import 'package:wardaya/features/favorites/data/apis/favorites_service.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/home/data/apis/home_service.dart';
import 'package:wardaya/features/home/data/repos/home_repo.dart';
import 'package:wardaya/features/home/logic/brands/brands_cubit.dart';
import 'package:wardaya/features/home/logic/categories/categories_cubit.dart';
import 'package:wardaya/features/invoices/data/apis/invoices_service.dart';
import 'package:wardaya/features/invoices/logic/cubit/invoices_cubit.dart';
import 'package:wardaya/features/my_occasions/data/apis/my_occassions_service.dart';
import 'package:wardaya/features/my_occasions/data/repos/my_occasions_repo.dart';
import 'package:wardaya/features/my_occasions/logic/create_occassion/cubit/create_occasion_cubit.dart';
import 'package:wardaya/features/my_occasions/logic/cubit/my_occasions_cubit.dart';
import 'package:wardaya/features/my_orders/data/apis/my_orders_service.dart';
import 'package:wardaya/features/my_orders/logic/cubit/my_orders_cubit.dart';
import 'package:wardaya/features/product_details/data/apis/product_details_service.dart';
import 'package:wardaya/features/product_details/data/repos/product_details_repo.dart';
import 'package:wardaya/features/product_details/logic/product_details/product_details_cubit.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/profile/data/apis/profile_service.dart';
import 'package:wardaya/features/profile/data/repos/profile_repo.dart';
import 'package:wardaya/features/search/data/apis/search_service.dart';
import 'package:wardaya/features/search/data/repos/search_repo.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';
import 'package:wardaya/features/subscriptions/data/apis/subscription_service.dart';
import 'package:wardaya/features/subscriptions/data/repos/subscription_repo.dart';
import 'package:wardaya/features/subscriptions/logic/durations/subscription_duration_cubit.dart';
import 'package:wardaya/features/subscriptions/logic/plans/subscription_cubit.dart';
import '../../features/address/logic/address_cubit/address_cubit.dart';
import '../../features/address/logic/recipient_details_cubit/recipient_details_cubit.dart';
import '../../features/authentication/apis/auth_service.dart';
import '../../features/authentication/create_account/data/repos/create_account_repo.dart';
import '../../features/authentication/create_account/logic/cubit/register_cubit.dart';
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/login/logic/cubit/login_cubit.dart';
import '../../features/cart/data/apis/cart_service.dart';
import '../../features/cart/logic/checkout/checkout_cubit.dart';
import '../../features/cart/logic/getCart/cubit/get_cart_cubit.dart';
import '../../features/cart/logic/promo/promo_cubit.dart';
import '../../features/favorites/data/repos/favorites_repo.dart';
import '../../features/home/logic/delivery_areas/delivery_areas_cubit.dart';
import '../../features/home/logic/gallery/gallery_cubit.dart';
import '../../features/home/logic/occassions/occassions_cubit.dart';
import '../../features/home/logic/recipients/recipients_cubit.dart';
import '../../features/invoices/data/repos/invoices_repo.dart';
import '../../features/layout/logic/cubit/layout_cubit.dart';
import '../../features/my_orders/data/repos/my_orders_repo.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
import '../../features/subscriptions/logic/subscription_checkout_cubit/subscription_checkout_cubit.dart';
import '../blocs/general/cubit/general_cubit.dart';
import '../networking/dio_factory.dart';
import '../../features/home/logic/new_ideas/new_ideas_cubit.dart';
import 'package:wardaya/features/cart/logic/uploadSignature/upload_signature_cubit.dart';

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
  getIt.registerLazySingleton<FavoritesService>(() => FavoritesService(dio));
  getIt.registerLazySingleton<ExploreService>(() => ExploreService(dio));
  getIt.registerLazySingleton<AddressService>(() => AddressService(dio));
  getIt.registerLazySingleton<MyOccassionsService>(
      () => MyOccassionsService(dio));
  getIt.registerLazySingleton<InvoicesService>(() => InvoicesService(dio));
  getIt.registerLazySingleton<ProductDetailsService>(
      () => ProductDetailsService(dio));
  getIt.registerLazySingleton<CartService>(() => CartService(dio));
  getIt.registerLazySingleton<MyOrdersService>(() => MyOrdersService(dio));
  getIt.registerLazySingleton<ProfileService>(() => ProfileService(dio));

  /************************* */
  /* ******** REPOS *********
  /************************ */
  */

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepo(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt(), getIt()));
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()));
  getIt
      .registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerLazySingleton<FavoritesRepo>(() => FavoritesRepo(getIt()));
  getIt.registerLazySingleton<ExploreRepo>(() => ExploreRepo(getIt()));
  getIt.registerLazySingleton<ProductDetailsRepo>(
      () => ProductDetailsRepo(productDetailsService: getIt()));

  getIt.registerLazySingleton<AddressRepo>(() => AddressRepo(getIt()));
  getIt.registerLazySingleton<MyOccasionsRepo>(() => MyOccasionsRepo(getIt()));
  getIt.registerLazySingleton<InvoicesRepo>(() => InvoicesRepo(getIt()));
  getIt.registerLazySingleton<MyOrdersRepo>(() => MyOrdersRepo(getIt()));
  getIt.registerLazySingleton<CartRepo>(() => CartRepo(getIt()));

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
  getIt.registerFactory<SubscriptionDurationCubit>(
      () => SubscriptionDurationCubit(getIt()));
  getIt.registerFactory<GalleryCubit>(() => GalleryCubit(getIt()));
  getIt.registerFactory<OccassionsCubit>(() => OccassionsCubit(getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
  getIt.registerFactory<BrandsCubit>(() => BrandsCubit(getIt()));
  getIt.registerFactory<RecipientsCubit>(() => RecipientsCubit(getIt()));
  getIt.registerFactory<DeliveryAreasCubit>(() => DeliveryAreasCubit(getIt()));
  getIt.registerFactory<NewIdeasCubit>(() => NewIdeasCubit(getIt()));
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit(getIt()));
  getIt.registerFactory<ExploreCubit>(() => ExploreCubit(getIt()));

  getIt.registerFactory<AddressCubit>(() => AddressCubit(getIt()));

  // Fix: Pass AddressRepo instance to RecipientDetailsCubit
  getIt.registerFactory<RecipientDetailsCubit>(
      () => RecipientDetailsCubit(getIt()));

  getIt.registerFactory<MyOccasionsCubit>(() => MyOccasionsCubit(getIt()));
  getIt.registerFactory<InvoicesCubit>(() => InvoicesCubit(getIt()));
  getIt
      .registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(getIt()));
  getIt.registerFactory<SubscriptionCheckoutCubit>(
      () => SubscriptionCheckoutCubit(getIt()));
  getIt.registerFactory<MyOrdersCubit>(() => MyOrdersCubit(getIt()));

  getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  getIt
      .registerFactory<CreateOccasionCubit>(() => CreateOccasionCubit(getIt()));
  getIt.registerFactory<AddToCartCubit>(() => AddToCartCubit(getIt()));
  getIt.registerFactory<GetCartCubit>(() => GetCartCubit(getIt()));
  getIt.registerFactory<RemoveCartCubit>(() => RemoveCartCubit(getIt()));
  getIt.registerFactory<GiftCardsCubit>(() => GiftCardsCubit(getIt()));
  getIt.registerFactory<UploadSignatureCubit>(
      () => UploadSignatureCubit(getIt()));
  getIt.registerFactory<VideoUploadCubit>(() => VideoUploadCubit(getIt()));
  getIt.registerFactory<CheckoutCubit>(() => CheckoutCubit(getIt()));
  getIt.registerFactory<PromoCubit>(() => PromoCubit(getIt()));
}
