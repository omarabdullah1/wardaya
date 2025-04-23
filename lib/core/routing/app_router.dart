import 'package:wardaya/features/address/logic/address_cubit/address_cubit.dart';
import 'package:wardaya/features/cart/logic/addToCart/cubit/add_to_cart_cubit.dart';
import 'package:wardaya/features/cart/logic/checkout/checkout_cubit.dart';
import 'package:wardaya/features/cart/logic/promo/promo_cubit.dart';
import 'package:wardaya/features/cart/ui/checkout_details_screen.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/home/logic/occassions/occassions_cubit.dart';
import 'package:wardaya/features/home/logic/recipients/recipients_cubit.dart';
import 'package:wardaya/features/invoices/logic/cubit/invoices_cubit.dart';
import 'package:wardaya/features/product_details/logic/product_details/product_details_cubit.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';
import 'package:wardaya/features/subscriptions/logic/durations/subscription_duration_cubit.dart';
import 'package:wardaya/features/subscriptions/logic/plans/subscription_cubit.dart';
import 'package:wardaya/features/explore/data/models/menu_items_response.dart';
import 'package:wardaya/features/subscriptions/logic/subscription_checkout_cubit/subscription_checkout_cubit.dart';

import '../../features/address/data/models/address_response.dart';
import '../../features/address/logic/recipient_details_cubit/recipient_details_cubit.dart';
import '../../features/address/ui/create_recipient_details_screen.dart';
import '../../features/cart/logic/videoUpload/video_upload_cubit.dart';
import '../../features/favorites/ui/favorites_screen.dart';
import '../../features/address/ui/addresses_screen.dart';
import '../../features/address/ui/recipient_details_screen.dart';
import '../../features/invoices/ui/invoices_screen.dart';
import '../../features/my_occasions/logic/cubit/my_occasions_cubit.dart';
import '../../features/my_occasions/ui/occassions_screen.dart';
import '../../features/my_orders/data/models/my_orders_response.dart'
    as my_order_response;
import '../../features/my_orders/logic/cubit/my_orders_cubit.dart';
import '../../features/my_orders/ui/my_orders_screen.dart';
import '../../features/my_orders/ui/order_details_screen.dart';
import '../../features/subscriptions/ui/subscripion_checkout.dart';
import '../../features/subscriptions/ui/subscription_duration_screen.dart';
import '../../features/subscriptions/ui/susbcriptions_screen.dart';
import 'router_imports.dart';
import '../../features/payment/ui/payment_method_screen.dart';
import '../../features/payment/ui/tap_payment_screen.dart';
import '../../features/cart/logic/giftCards/gift_cards_cubit.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return _buildRoute(screen: const SplashScreen());

      case Routes.loginScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const SignInScreen(),
          ),
        );
      case Routes.homeLayout:
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CartCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<LayoutCubit>(),
              ),
            ],
            child: HomeLayout(arguments: arguments as Map<String, dynamic>?),
          ),
        );
      case Routes.searchScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<SearchCubit>(),
            child: const SearchScreen(),
          ),
        );
      case Routes.momentsScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<OccassionsCubit>()..getHomeOccassions(),
            child: const MomentsScreen(),
          ),
        );
      case Routes.recipientsScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<RecipientsCubit>()..getRecipients(),
            child: const RecipientsScreen(),
          ),
        );
      case Routes.subMenuItemsScreen:
        if (arguments is Map<String, dynamic>) {
          final BuildContext cartContext = arguments['context'] as BuildContext;
          final MenuItem menuItem = arguments['menuItem'] as MenuItem;

          return _buildRoute(
            screen: SubMenuItemsScreen(
              cartContext: cartContext,
              menuItem: menuItem,
            ),
          );
        } else {
          // Fallback for backward compatibility
          return _buildRoute(
            screen: SubMenuItemsScreen(
              cartContext: (arguments as BuildContext),
              menuItem: MenuItem(
                id: "",
                imageUrl: "",
                name: "Menu Items",
                subMenuItems: [],
              ),
            ),
          );
        }

      case Routes.categoryScreen:
        if (arguments is Map<String, dynamic>) {
          final extraArgs = arguments['extraArgs'] as String?;
          final String? occasionId = arguments['occasionId'] as String?;
          final String? categoryId = arguments['categoryId'] as String?;
          final String? subCategoryId = arguments['subCategoryId'] as String?;
          final String? recipientId = arguments['recipientId'] as String?;
          final String? brandId = arguments['brandId'] as String?;
          final String? subMenuItemsId = arguments['subMenuItemsId'] as String?;
          final bool expressDelivery =
              arguments['expressDelivery'] as bool? ?? false;

          // Create instances of required cubits
          final searchCubit = getIt<SearchCubit>();
          final layoutCubit = getIt<LayoutCubit>();

          return _buildRoute(
            screen: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: searchCubit),
                BlocProvider.value(value: layoutCubit),
              ],
              child: CategoryScreen(
                momentTitle: extraArgs ?? "",
                occasionId: occasionId,
                categoryId: categoryId,
                subCategoryId: subCategoryId,
                recipientId: recipientId,
                brandId: brandId,
                subMenuItemsId: subMenuItemsId,
                expressDelivery: expressDelivery,
              ),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }
      case Routes.productDetailsScreen:
        if (arguments is Map<String, dynamic>) {
          final extraArgs = arguments['extraArgs'] as Product;
          return _buildRoute(
            screen: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<FavoritesCubit>()..getFavorites(),
                ),
                BlocProvider(
                  create: (context) => getIt<ProductDetailsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AddToCartCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<CartCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<LayoutCubit>(),
                ),
              ],
              child: ProductDetailsScreen(
                product: extraArgs,
              ),
            ),
          );
        } else {
          throw ArgumentError(
              "Invalid arguments for ${Routes.productDetailsScreen}");
        }

      case Routes.forgetPasswordScreen:
        return _buildRoute(screen: const ForgetPasswordScreen());
      case Routes.createAccountScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const CreateAccountScreen(),
          ),
        );
      case Routes.profileScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getProfile(context),
            child: const ProfileScreen(),
          ),
        );

      case Routes.addressesScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (_) => getIt<AddressCubit>()..getAddresses(),
            child: const AddressesScreen(),
          ),
        );
      case Routes.recipientDetailsScreen:
        if (arguments is Map<String, dynamic>) {
          final extraArgs = arguments['extraArgs'] as Address;
          return _buildRoute(
            screen: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => getIt<RecipientDetailsCubit>(),
                ),
                BlocProvider(
                  create: (_) => getIt<AddressCubit>(),
                ),
              ],
              child: RecipientDetailsScreen(
                address: extraArgs,
              ),
            ),
          );
        } else {
          throw ArgumentError(
              "Invalid arguments for ${Routes.productDetailsScreen}");
        }
      case Routes.createRecipientDetailsScreen:
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<RecipientDetailsCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<AddressCubit>(),
              ),
            ],
            child: const CreateRecipientDetailsScreen(),
          ),
        );

      case Routes.faqScreen:
        return _buildRoute(screen: const FAQScreen());
      case Routes.tacScreen:
        return _buildRoute(screen: const TACScreen());
      case Routes.customizeGiftCardScreen:
        final List args = arguments as List;
        final BuildContext parentContext = args[1] as BuildContext;
        final CartCubit cartCubit = BlocProvider.of<CartCubit>(parentContext);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: cartCubit,
                ),
                BlocProvider(
                  create: (_) => getIt<GiftCardsCubit>()..getGiftCards(),
                ),
              ],
              child: CustomizeGiftCardScreen(
                initialTabIndex: args[0] as int,
                parentContext: parentContext,
              ),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.recordScreen:
        if (arguments is Map<String, dynamic>) {
          final extraArgs = arguments['extraArgs'] as CartCubit;

          return _buildRoute(
            screen: BlocProvider(
              create: (context) => getIt<VideoUploadCubit>(),
              child: RecordScreen(
                cartCubit: extraArgs,
              ),
            ),
          );
        } else {
          throw ArgumentError("Invalid arguments for ${Routes.categoryScreen}");
        }

      case Routes.editProfileScreen:
        final cubit =
            (arguments as Map<String, dynamic>?)?['cubit'] as ProfileCubit?;
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(
                value: cubit!,
              ),
              BlocProvider(
                create: (context) => getIt<AddressCubit>(),
              ),
            ],
            child: const EditProfileScreen(),
          ),
        );
      case Routes.susbcriptionsScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) =>
                getIt<SubscriptionCubit>()..emitGetSubscription(),
            child: const SusbcriptionsScreen(),
          ),
        );
      case Routes.tapPaymentScreen:
        final Map<String, dynamic> args = arguments as Map<String, dynamic>;
        return _buildRoute(
          screen: TapPaymentScreen(
            amount: args['amount'],
            // orderId: args['orderId'],
            // firstName: args['firstName'],
            // lastName: args['lastName'],
            // email: args['email'],
            // phoneNumber: args['phoneNumber'],
            // countryCode: args['countryCode'],
            paymentMethod: args['paymentMethod'],
            redirectUrl: args['redirectUrl'],
          ),
        );
      case Routes.susbcriptionsDurationScreen:
        final Map<String, dynamic> args = arguments as Map<String, dynamic>;

        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SubscriptionCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<SubscriptionDurationCubit>()
                  ..emitGetSubscriptionDurations(),
              ),
            ],
            child: SubscriptionDurationScreen(
              planId: args['planId'],
              title: args['title'],
              price: args['price'],
              currency: args['currency'],
            ),
          ),
        );
      case Routes.subscripionCheckout:
        final Map<String, dynamic> args = arguments as Map<String, dynamic>;
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<SubscriptionCheckoutCubit>(),
            child: SubscripionCheckout(
              subscriptionPlan: args['subscriptionPlan'] as String,
              deliveryFrequency: args['deliveryFrequency'] as String,
              subscriptionDuration: args['subscriptionDuration'] as String,
              startDate: args['selectedDate'],
              price: args['price'],
              currency: args['currency'],
            ),
          ),
        );
      case Routes.favoritesScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<FavoritesCubit>()..getFavorites(),
            child: const FavoritesScreen(),
          ),
        );
      case Routes.invoicesScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (context) => getIt<InvoicesCubit>()..getInvoices(),
            child: const InvoicesScreen(),
          ),
        );
      case Routes.occasionsScreen:
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<MyOccasionsCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<OccassionsCubit>()..getHomeOccassions(),
              ),
              BlocProvider(
                create: (context) => getIt<RecipientsCubit>()..getRecipients(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<MyOccasionsCubit>()..getMyOccasions(),
              ),
            ],
            child: const OccasionsScreen(),
          ),
        );

      case Routes.paymentMethodScreen:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
          screen: PaymentMethodScreen(
            amount: args['amount'] as double,
          ),
        );
      // case Routes.tapPaymentScreen:
      //   final Map<String, dynamic> args =
      //       settings.arguments as Map<String, dynamic>;
      //   return _buildRoute(
      //     screen: TapPaymentScreen(
      //       amount: args['amount'] as double,
      //       orderId: args['orderId'] as String,
      //       firstName: args['firstName'] as String? ?? "John",
      //       lastName: args['lastName'] as String? ?? "Smith",
      //       email: args['email'] as String? ?? "customer@example.com",
      //       phoneNumber: args['phoneNumber'] as String? ?? "566123456",
      //       countryCode: args['countryCode'] as String? ?? "+966",
      //       paymentMethod: args['paymentMethod'] as String?,
      //     ),
      //   );
      case Routes.myOrdersScreen:
        return _buildRoute(
          screen: BlocProvider(
            create: (_) => getIt<MyOrdersCubit>()..getOrders(),
            child: const MyOrdersScreen(),
          ),
        );
      case Routes.orderDetailsScreen:
        if (arguments is my_order_response.Order) {
          return _buildRoute(
            screen: OrderDetailsScreen(
              order: arguments,
            ),
          );
        }
        throw ArgumentError(
            "Invalid arguments for ${Routes.orderDetailsScreen}");
      case Routes.chckoutDetails:
        final Map<String, dynamic> args = arguments as Map<String, dynamic>;
        return _buildRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CheckoutCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<PromoCubit>(),
              ),
            ],
            child: CheckoutDetails(
              giftCardId: args['giftCardId'],
              price: args['price'],
              currency: args['currency'],
              to: args['to'],
              message: args['message'],
              from: args['from'],
              signatureLink: args['signatureLink'],
              link: args['link'],
              videoLink: args['videoLink'],
              selectedTypingStyle: args['selectedTypingStyle'],
              cartItems: args['cartItems'],
            ),
          ),
        );
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute({required Widget screen}) {
    return MaterialPageRoute(
      builder: (context) => screen,
    );
  }
}
