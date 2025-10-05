import 'package:fashion/feature/account/domain/entities/order_entity.dart';
import 'package:fashion/feature/account/presentation/controller/customer_service/customer_service_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/customser_service_websocket/customer_service_websocket_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/faqs/fa_qs_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/myDetails/my_details_bloc.dart';
import 'package:fashion/feature/account/presentation/controller/order/order_bloc.dart';
import 'package:fashion/feature/account/presentation/page/account_page.dart';
import 'package:fashion/feature/account/presentation/page/address_book_page.dart';
import 'package:fashion/feature/account/presentation/page/customer_service_page.dart';
import 'package:fashion/feature/account/presentation/page/f_a_qs_page.dart';
import 'package:fashion/feature/account/presentation/page/help_center_page.dart';
import 'package:fashion/feature/account/presentation/page/my_details_page.dart';
import 'package:fashion/feature/account/presentation/page/my_order_page.dart';
import 'package:fashion/feature/account/presentation/page/notifcation_setting_page.dart';
import 'package:fashion/feature/account/presentation/page/payment_method_page.dart';
import 'package:fashion/feature/account/presentation/page/setting_app_page.dart';
import 'package:fashion/feature/account/presentation/page/trakcking_order_page.dart';
import 'package:fashion/feature/auth/domain/entities/users.dart';
import 'package:fashion/feature/cart/presentation/controller/controller/cart_bloc.dart';
import 'package:fashion/feature/cart/presentation/page/cart_page.dart';
import 'package:fashion/core/constant/name_app_route.dart';
import 'package:fashion/feature/auth/presentation/pages/log/login_screen.dart';
import 'package:fashion/feature/auth/presentation/pages/onbording.dart';
import 'package:fashion/feature/auth/presentation/pages/reset_password/enter_email_screen.dart';
import 'package:fashion/feature/auth/presentation/pages/reset_password/reset_password_screen.dart';
import 'package:fashion/feature/auth/presentation/pages/reset_password/verifi_eamil_for_reset_pass_screen.dart';
import 'package:fashion/feature/auth/presentation/pages/signup/signup_screen.dart';
import 'package:fashion/feature/auth/presentation/pages/verifi_signup_screen.dart';
import 'package:fashion/feature/checkout/presentation/controller/add_card/add_card_bloc.dart';
import 'package:fashion/feature/checkout/presentation/controller/add_loaction/add_location_bloc.dart';
import 'package:fashion/feature/checkout/presentation/controller/checkout/checkout_bloc.dart';
import 'package:fashion/feature/checkout/presentation/page/add_new_card_screen.dart';
import 'package:fashion/feature/checkout/presentation/page/checkout_screen.dart';
import 'package:fashion/feature/checkout/presentation/page/payment_method_screen.dart';
import 'package:fashion/feature/checkout/presentation/page/saved_address_screen.dart';
import 'package:fashion/feature/home/domain/entiti/discove_entities.dart';
import 'package:fashion/feature/home/presentation/page/home_page.dart';
import 'package:fashion/feature/notification/presentation/page/notification_screen.dart';
import 'package:fashion/feature/product_details/presentation/controller/controller/product_details_bloc.dart';
import 'package:fashion/feature/product_details/presentation/controller/reviews/reviews_bloc.dart';
import 'package:fashion/feature/product_details/presentation/page/product_detatils_screen.dart';
import 'package:fashion/feature/product_details/presentation/page/product_review_screen.dart';
import 'package:fashion/feature/saved/presentation/page/saved_screen.dart';
import 'package:fashion/feature/search/presentation/controller/controller/search_bloc.dart';
import 'package:fashion/feature/search/presentation/page/search_page.dart';
import 'package:fashion/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/class/seen_secreen.dart';
import 'feature/account/presentation/controller/track_order/track_order_bloc.dart';
import 'feature/auth/presentation/controller/login/login_bloc.dart';
import 'feature/auth/presentation/controller/onbording/onboarding_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/enter_email/enter_email_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/reset_password/reset_password_bloc.dart';
import 'feature/auth/presentation/controller/reset_password/verifi_email_for_reset/verifi_email_bloc.dart';
import 'feature/auth/presentation/controller/signup/signup/signup_bloc.dart';
import 'feature/auth/presentation/controller/signup/verifi_signup/verifi_signup_bloc.dart';
import 'feature/checkout/presentation/page/add_new_location_screen.dart';
import 'injiction_container.dart' as di;

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _searchNavigatorKey = GlobalKey<NavigatorState>();
  static final _savedNavigatorKey = GlobalKey<NavigatorState>();
  static final _cartNavigatorKey = GlobalKey<NavigatorState>();
  static final _accountNavigatorKey = GlobalKey<NavigatorState>();
  final goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) async {
      String screenName = await SeenSecreen().getSeenScreen();
      final currentPath = state.matchedLocation;
      if (_isPublicRoute(currentPath)) {
        return null;
      }
      if (screenName == NameAppRoute.login) {
        return NameAppRoute.home;
      } else if (screenName == NameAppRoute.onBoarding) {
        return NameAppRoute.login;
      }
      return null;
    },
    routes: [
      // GoRoute(
      //   path: "/test",
      //   builder: (context, state) {
      //     return BlocProvider(
      //       create: (context) => di.sl<CustomerServiceBloc>(),
      //       child: Test(),
      //     );
      //   },
      // ),
      GoRoute(
        path: "/",
        name: NameAppRoute.onBoarding,
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<OnboardingBloc>(),
          child: const Onbording(),
        ),
      ),
      GoRoute(
        path: NameAppRoute.login,
        name: NameAppRoute.login,
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<LoginBloc>(),
          child: LoginScreen(),
        ),
        routes: [
          GoRoute(
            name: NameAppRoute.signUp,
            path: NameAppRoute.signUp,
            builder: (context, state) => BlocProvider(
              create: (_) => di.sl<SignupBloc>(),
              child: SignupScreen(),
            ),
          ),
          GoRoute(
            path: NameAppRoute.enterEmail,
            name: NameAppRoute.enterEmail,
            builder: (context, state) => BlocProvider(
              create: (_) => di.sl<EnterEmailBloc>(),
              child: EnterEmailScreen(),
            ),
            routes: [
              GoRoute(
                path: "${NameAppRoute.verifiPass}/:email",
                name: NameAppRoute.verifiPass,
                builder: (context, state) {
                  String email = state.pathParameters['email']!;
                  return BlocProvider(
                    create: (_) => di.sl<VerifiEmailBloc>(),
                    child: VerifiEamilForResetPassScreen(email: email),
                  );
                },
              ),
              GoRoute(
                path: "${NameAppRoute.resetaPassword}/:email",
                name: NameAppRoute.resetaPassword,
                builder: (context, state) {
                  String email = state.pathParameters['email']!;
                  return BlocProvider(
                    create: (_) => di.sl<ResetPasswordBloc>(),
                    child: ResetPasswordScreen(email: email),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "${NameAppRoute.verifiSignUp}/:email",
        name: NameAppRoute.verifiSignUp,
        builder: (context, state) {
          final String email = state.pathParameters['email']!;
          return BlocProvider(
            create: (_) => di.sl<VerifiSignupBloc>(),
            child: VerifiSignupScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: "/details/:fromPage",
        name: NameAppRoute.productDetails,
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          final int fromHome = int.parse(state.pathParameters['fromPage']!);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.sl<ProductDetailsBloc>()),
            ],
            child: ProductDetatilsScreen(
              productEntiti: product,
              fromPage: fromHome,
            ),
          );
        },
        routes: [
          GoRoute(
            name: "reviews",
            path: "reviews",
            builder: (context, state) {
              final product = state.extra as ProductEntity;
              return MultiBlocProvider(
                providers: [BlocProvider(create: (_) => di.sl<ReviewsBloc>())],
                child: ProductReviewScreen(productEntiti: product),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: "/checkout",
        name: "checkout",
        builder: (context, state) {
          return const CheckoutScreen();
        },
        routes: [
          GoRoute(
            path: "savedAddress",
            name: "savedAddress",
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: di.sl<CheckoutBloc>()
                      ..add(const GetAllLocationEvent()),
                  ),
                ],
                child: const SavedAddressScreen(),
              );
            },
            routes: [
              GoRoute(
                path: "AddLocation",
                name: "AddLocation",
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => di.sl<AddLocationBloc>()),
                    ],
                    child: AddNewLocationScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: "savedCards",
            name: "savedCards",
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [BlocProvider.value(value: di.sl<CheckoutBloc>())],
                child: const PaymentMethodScreen(),
              );
            },
            routes: [
              GoRoute(
                path: "AddCard",
                name: "AddCard",
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => di.sl<AddCardBloc>()),
                    ],
                    child: AddNewCardScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/trackOrder",
        name: NameAppRoute.trackOrder,
        builder: (context, state) {
          final order = state.extra as OrderEntity;
          return MultiBlocProvider(
            providers: [BlocProvider(create: (_) => di.sl<TrackOrderBloc>())],
            child: TrakckingOrderPage(order: order),
          );
        },
      ),
      GoRoute(
        path: "/customerService",
        name: NameAppRoute.customerService,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                di.sl<CustomerServiceWebsocketBloc>()
                  ..add(InitChatMessageEvent()),
            child: CustomerServicePage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          _buildBranch(
            _homeNavigatorKey,
            '/home',
            NameAppRoute.home,
            const HomePage(),
            [
              GoRoute(
                path: "notification",
                builder: (context, state) => const NotificationScreen(),
              ),
            ],
          ),
          _buildBranch(
            _searchNavigatorKey,
            '/search',
            NameAppRoute.search,
            BlocProvider(
              create: (_) =>
                  di.sl<SearchBloc>()..add(GetCachedResultSearchEvent()),
              child: SearchPage(),
            ),
            [],
          ),
          _buildBranch(
            _savedNavigatorKey,
            "/saved",
            NameAppRoute.saved,
            const SavedScreen(),
            [],
          ),
          _buildBranch(
            _cartNavigatorKey,
            '/cart',
            NameAppRoute.cart,
            BlocProvider(
              create: (_) => di.sl<CartBloc>(),
              child: const CartPage(),
            ),
            [],
          ),
          _buildBranch(
            _accountNavigatorKey,
            '/account',
            NameAppRoute.account,
            const AccountPage(),
            [
              GoRoute(
                path: "myOrder",
                name: NameAppRoute.myOrder,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => di.sl<OrderBloc>(),
                    child: const MyOrderPage(),
                  );
                },
              ),
              GoRoute(
                path: "myDetails",
                name: NameAppRoute.myDetails,
                builder: (context, state) {
                  final user = state.extra as UserEntite;
                  return BlocProvider(
                    create: (_) => di.sl<MyDetailsBloc>(),
                    child: MyDetailsPage(user: user),
                  );
                },
              ),
              GoRoute(
                path: "addressBook",
                name: NameAppRoute.addressBook,
                builder: (context, state) {
                  return const AddressBookPage();
                },
              ),
              GoRoute(
                path: "paymentMethod",
                name: NameAppRoute.paymentMethodBook,
                builder: (context, state) {
                  return const PaymentMethodPage();
                },
              ),
              GoRoute(
                path: "settingApp",
                name: NameAppRoute.settingApp,
                builder: (context, state) {
                  return const SettingAppPage();
                },
              ),
              GoRoute(
                path: "settingNotifcation",
                name: NameAppRoute.settingNotification,
                builder: (context, state) {
                  return const NotifcationSettingPage();
                },
              ),
              GoRoute(
                path: "FAQs",
                name: NameAppRoute.fAQs,
                builder: (context, state) {
                  return BlocProvider(
                    create: (_) =>
                        di.sl<FaQsBloc>()..add(const GetGenralFAQsEvent()),
                    child: const FAQsPage(),
                  );
                },
              ),
              GoRoute(
                path: "helpCenter",
                name: NameAppRoute.helpCenter,
                builder: (context, state) {
                  return const HelpCenterPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
  static bool _isPublicRoute(String path) {
    final publicRoute = [
      NameAppRoute.login,
      "${NameAppRoute.login}${NameAppRoute.signUp}",
      NameAppRoute.verifiSignUp,
      "${NameAppRoute.login}${NameAppRoute.enterEmail}",
      "${NameAppRoute.login}${NameAppRoute.enterEmail}${NameAppRoute.verifiPass}",
      "${NameAppRoute.login}${NameAppRoute.enterEmail}${NameAppRoute.resetaPassword}",
      NameAppRoute.home,
      NameAppRoute.search,
      NameAppRoute.saved,
      NameAppRoute.cart,
      NameAppRoute.account,
      NameAppRoute.productDetails,
      "/home/notification",
      "/details/reviews",
      "/checkout",
      "/checkout/savedAddress",
      "/checkout/savedCards",
      "/checkout/savedCards/AddCard",
      "/checkout/savedCards/AddLocation",
      "${NameAppRoute.account}${NameAppRoute.myOrder}",
      "${NameAppRoute.account}${NameAppRoute.myDetails}",
      "${NameAppRoute.account}${NameAppRoute.addressBook}",
      "${NameAppRoute.account}${NameAppRoute.paymentMethodBook}",
      "${NameAppRoute.account}${NameAppRoute.settingApp}",
      "${NameAppRoute.account}${NameAppRoute.settingNotification}",
      "${NameAppRoute.account}${NameAppRoute.fAQs}",
      "${NameAppRoute.account}${NameAppRoute.helpCenter}",
      NameAppRoute.trackOrder,
      NameAppRoute.customerService,
    ];
    return publicRoute.any((route) => path.startsWith(route));
  }

  static StatefulShellBranch _buildBranch(
    GlobalKey<NavigatorState> key,
    String path,
    String name,
    Widget page,
    List<RouteBase> routes,
  ) {
    return StatefulShellBranch(
      navigatorKey: key,
      routes: [
        GoRoute(
          path: path,
          name: name,
          builder: (context, state) => page,
          routes: routes,
        ),
      ],
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
