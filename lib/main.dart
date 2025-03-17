import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/navigation/app_navigation.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/core/theme/theme.dart';
import 'package:nextrade/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nextrade/features/auth/presentation/pages/login_page.dart';
import 'package:nextrade/features/home/presentation/bloc/home_bloc.dart';
import 'package:nextrade/features/home/presentation/pages/home_page.dart';
import 'package:nextrade/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:nextrade/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nextrade/features/profile/presentation/pages/edit_password_page.dart';
import 'package:nextrade/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:nextrade/features/profile/presentation/pages/profile_page.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:nextrade/init_dependencies.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final bool isUserLoggedIn = await TokenStorage.checkLoginStatus();
//   runApp(const MyApp(_);
// }

Future<void> main() async {
  final apiClient = ApiClient();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<StockBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<HomeBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<PortfolioBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<WatchlistBloc>(),
      ),
      // BlocProvider(
      //   create: (_) => AuthBloc(
      //     userSignUp: UserSignUp(
      //       AuthRepositoryImpl(
      //         AuthRemoteDataSourceImpl(apiClient),
      //       ),
      //     ),
      //   ),
      // ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) => state is AppUserLoggedIn,
      builder: (context, isLoggedIn) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.darkThemeMode,
          routerConfig: AppNavigation.getRouter(isLoggedIn),
        );
      },
    );
  }

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Flutter Demo',
//     // theme: ThemeData(
//     //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//     //   useMaterial3: true,
//     // ),
//     theme: AppTheme.darkThemeMode,
//     home: const EditProfilePage(),
//     // home: BlocSelector<AppUserCubit, AppUserState, bool>(
//     //   selector: (state) {
//     //     return state is AppUserLoggedIn;
//     //   },
//     //   builder: (context, isLoggedIn) {
//     //     if (isLoggedIn) {
//     //       return const HomePage();
//     //     }
//     //     return const LoginPage();
//     //   },
//     // ),
//   );
// }
}
// CTRL + SPACE
// ALT + ENTER
// CTRL + ALT + L => Formatting
// SHIFT + CTRL + R => Find files
// ALT + SHIFT => Multi cursor
