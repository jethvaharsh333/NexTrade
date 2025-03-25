import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/navigation/main_wrapper.dart';
import 'package:nextrade/features/auth/presentation/pages/login_page.dart';
import 'package:nextrade/features/home/presentation/pages/home_page.dart';
import 'package:nextrade/features/learning/presentation/pages/learning_page.dart';
import 'package:nextrade/features/portfolio/presentation/pages/edit_portfolio.dart';
import 'package:nextrade/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:nextrade/features/profile/presentation/pages/edit_password_page.dart';
import 'package:nextrade/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:nextrade/features/profile/presentation/pages/profile_page.dart';
import 'package:nextrade/features/stock/presentation/pages/stock_detail_page.dart';
import 'package:nextrade/features/stock/presentation/pages/stock_list_page.dart';
import 'package:nextrade/features/watchlist/presentation/pages/watchlist_page.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/home";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSearch = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
  static final _shellNavigatorPortfolio = GlobalKey<NavigatorState>(debugLabel: 'shellPortfolio');
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  // GoRouter configuration
  // static final GoRouter router = GoRouter(
  //   initialLocation: initial,
  //   debugLogDiagnostics: true,
  //   navigatorKey: _rootNavigatorKey,
  //   routes: [
  //     /// MainWrapper
  //     // StatefulShellRoute.indexedStack(
  //       // builder: (context, state, navigationShell) {
  //       //   return MainWrapper(
  //       //     navigationShell: navigationShell,
  //       //   );
  //       // },
  //       // branches: <StatefulShellBranch>[
  //       //   StatefulShellBranch(
  //       //     navigatorKey: _shellNavigatorHome,
  //       //     routes: <RouteBase>[
  //       //       GoRoute(
  //       //         path: "/home",
  //       //         name: "Home",
  //       //         builder: (BuildContext context, GoRouterState state) =>
  //       //         const HomePage(),
  //       //       ),
  //       //     ],
  //       //   ),
  //       //
  //       //   StatefulShellBranch(
  //       //     navigatorKey: _shellNavigatorSettings,
  //       //     routes: <RouteBase>[
  //       //       GoRoute(
  //       //         path: "/search",
  //       //         name: "Search",
  //       //         builder: (BuildContext context, GoRouterState state) =>
  //       //         const SearchPage(),
  //       //         routes: [
  //       //           GoRoute(
  //       //             path: "stockdetail",
  //       //             name: "StockDetail",
  //       //             pageBuilder: (context, state) {
  //       //               return CustomTransitionPage<void>(
  //       //                 key: state.pageKey,
  //       //                 child: const StockDetailPage(),
  //       //                 transitionsBuilder: (
  //       //                     context,
  //       //                     animation,
  //       //                     secondaryAnimation,
  //       //                     child,
  //       //                     ) =>
  //       //                     FadeTransition(opacity: animation, child: child),
  //       //               );
  //       //             },
  //       //           ),
  //       //         ],
  //       //       ),
  //       //     ],
  //       //   ),
  //       //
  //       //   StatefulShellBranch(
  //       //     navigatorKey: _shellNavigatorPortfolio,
  //       //     routes: <RouteBase>[
  //       //       GoRoute(
  //       //         path: "/portfolio",
  //       //         name: "Portfolio",
  //       //         builder: (BuildContext context, GoRouterState state) =>
  //       //         const PortfolioPage(),
  //       //       ),
  //       //     ],
  //       //   ),
  //       //
  //       //   StatefulShellBranch(
  //       //     navigatorKey: _shellNavigatorProfile,
  //       //     routes: <RouteBase>[
  //       //       GoRoute(
  //       //         path: "/profile",
  //       //         name: "Profile",
  //       //         builder: (BuildContext context, GoRouterState state) =>
  //       //         const ProfilePage(),
  //       //       ),
  //       //     ],
  //       //   ),
  //       // ],
  //     // ),
  //
  //
  //
  //     /// Player
  //     // GoRoute(
  //     //   parentNavigatorKey: _rootNavigatorKey,
  //     //   path: '/learning',
  //     //   name: "Learning",
  //     //   builder: (context, state) => LearningPage(
  //     //     key: state.pageKey,
  //     //   ),
  //     // )
  //   ],
  // );

  static final mainShellRoute = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return MainWrapper(
        navigationShell: navigationShell,
      );
    },
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        navigatorKey: _shellNavigatorHome,
        routes: <RouteBase>[
          GoRoute(
            path: "/home",
            name: "Home",
            builder: (BuildContext context, GoRouterState state) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorSearch,
        routes: <RouteBase>[
          GoRoute(
            path: "/search",
            name: "Search",
            builder: (BuildContext context, GoRouterState state) => StockListPage(),
            routes: [
              GoRoute(
                path: "stockdetail/:stockSymbol",
                name: "StockDetail",
                pageBuilder: (context, state) {
                  final stockSymbol = state.pathParameters['stockSymbol'];

                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: StockDetailPage(stockSymbol: stockSymbol!),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorPortfolio,
        routes: <RouteBase>[
          GoRoute(
            path: "/portfolio",
            name: "Portfolio",
            builder: (BuildContext context, GoRouterState state) => const PortfolioPage(),
            routes: [
              GoRoute(
                path: "editportfolio",
                name: "EditPortfolio",
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: EditPortfolio(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _shellNavigatorProfile,
        routes: <RouteBase>[
          GoRoute(
            path: "/profile",
            name: "Profile",
            builder: (BuildContext context, GoRouterState state) => const ProfilePage(),
            routes: [
              GoRoute(
                path: "editprofile",
                name: "EditProfile",
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const EditProfilePage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
              GoRoute(
                path: "editpassword",
                name: "EditPassword",
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const EditPasswordPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        FadeTransition(opacity: animation, child: child),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static List<RouteBase> get routes => [
        // Auth route
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        // Main app shell route
        mainShellRoute,
        // Other routes
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/learning',
          name: "Learning",
          builder: (context, state) => LearningPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/watchlist',
          name: "Watchlist",
          builder: (context, state) => WatchlistPage(
            key: state.pageKey,
          ),
        ),

      ];

  static GoRouter getRouter(bool isLoggedIn) => GoRouter(
        initialLocation: isLoggedIn ? initial : '/login',
        debugLogDiagnostics: true,
        navigatorKey: _rootNavigatorKey,
        routes: routes,
        redirect: (context, state) {
          // If not logged in, only allow access to login
          if (!isLoggedIn && state.matchedLocation != '/login') {
            return '/login';
          }
          // If logged in and on login page, go to home
          if (isLoggedIn && state.matchedLocation == '/login') {
            return '/portfolio';
          }

          return null;

          // return '/profile/editprofile';
        },
      );
}
