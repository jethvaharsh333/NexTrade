import 'package:get_it/get_it.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nextrade/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nextrade/features/auth/domain/repository/auth_repository.dart';
import 'package:nextrade/features/auth/domain/usecases/current_user.dart';
import 'package:nextrade/features/auth/domain/usecases/user_login.dart';
import 'package:nextrade/features/auth/domain/usecases/user_sign_up.dart';
import 'package:nextrade/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nextrade/features/home/data/datasources/home_remote_data_source.dart';
import 'package:nextrade/features/home/data/repositories/home_repository_impl.dart';
import 'package:nextrade/features/home/domain/repository/home_repository.dart';
import 'package:nextrade/features/home/domain/usecases/get_stock_indices.dart';
import 'package:nextrade/features/home/presentation/bloc/home_bloc.dart';
import 'package:nextrade/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:nextrade/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:nextrade/features/portfolio/domain/repository/portfolio_repository.dart';
import 'package:nextrade/features/portfolio/domain/usecases/add_stock_to_portfolio.dart';
import 'package:nextrade/features/portfolio/domain/usecases/get_stock_portfolio.dart';
import 'package:nextrade/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:nextrade/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:nextrade/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:nextrade/features/profile/domain/repository/profile_repository.dart';
import 'package:nextrade/features/profile/domain/usecases/edit_password.dart';
import 'package:nextrade/features/profile/domain/usecases/edit_profile.dart';
import 'package:nextrade/features/profile/domain/usecases/logout_profile.dart';
import 'package:nextrade/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:nextrade/features/stock/data/datasources/stock_remote_data_soure.dart';
import 'package:nextrade/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';
import 'package:nextrade/features/stock/domain/usecases/add_to_watchlist.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_financials_object.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_list.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_price_list.dart';
import 'package:nextrade/features/stock/domain/usecases/get_watchlist_stocks.dart';
import 'package:nextrade/features/stock/domain/usecases/remove_stock_from_watchlist.dart';

// import 'package:nextrade/features/watchlist/domain/usecases/remove_from_watchlist.dart';
import 'package:nextrade/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:nextrade/features/watchlist/data/datasources/watchlist_remote_data_source.dart';
import 'package:nextrade/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:nextrade/features/watchlist/domain/repository/watchlist_repository.dart';
import 'package:nextrade/features/watchlist/domain/usecases/fetch_watchlist_stocks_with_finance.dart';
import 'package:nextrade/features/watchlist/domain/usecases/remove_from_watchlist.dart';

// import 'package:nextrade/features/watchlist/domain/usecases/remove_from_watchlist.dart';
import 'package:nextrade/features/watchlist/presentation/bloc/watchlist_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  _initStock();
  _initHome();
  _initPortfolio();
  _initWatchlist();

  final apiClient = ApiClient();
  serviceLocator.registerLazySingleton(() => apiClient);

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<ProfileRepository>(() => ProfileRepositoryImpl(serviceLocator()))
    ..registerFactory(() => EditPassword(serviceLocator()))
    ..registerFactory(() => EditProfile(serviceLocator()))
    ..registerFactory(() => LogoutProfile(serviceLocator()))
    ..registerLazySingleton(
      () => ProfileBloc(
        editPassword: serviceLocator(),
        editProfile: serviceLocator(),
        logoutProfile: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initStock() {
  serviceLocator
    ..registerFactory<StockRemoteDataSource>(() => StockRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<StockRepository>(() => StockRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetStockList(serviceLocator()))
    ..registerFactory(() => GetStockPriceList(serviceLocator()))
    ..registerFactory(() => GetStockFinancialsObject(serviceLocator()))
    ..registerFactory(() => AddToWatchList(serviceLocator()))
    ..registerFactory(() => GetWatchlistStocks(serviceLocator()))
    ..registerFactory(() => RemoveStockFromWatchlist(serviceLocator()))
    ..registerLazySingleton(
      () => StockBloc(
        getStockList: serviceLocator(),
        getStockPriceList: serviceLocator(),
        getStockFinancialsObject: serviceLocator(),
        addToWatchList: serviceLocator(),
        getWatchlistStocks: serviceLocator(),
        removeStockFromWatchlist: serviceLocator(),
      ),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<HomeRepository>(() => HomeRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetStockIndices(serviceLocator()))
    ..registerLazySingleton(
      () => HomeBloc(
        getStockIndices: serviceLocator(),
      ),
    );
}

void _initPortfolio() {
  serviceLocator
    ..registerFactory<PortfolioRemoteDataSource>(() => PortfolioRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<PortfolioRepository>(() => PortfolioRepositoryImpl(serviceLocator()))
    ..registerFactory(() => AddStockToPortfolio(serviceLocator()))
    ..registerFactory(() => GetStockPortfolio(serviceLocator()))
    ..registerLazySingleton(
      () => PortfolioBloc(
        addStockToPortfolio: serviceLocator(),
        getStockPortfolio: serviceLocator(),
      ),
    );
}

void _initWatchlist() {
  serviceLocator
    ..registerFactory<WatchlistRemoteDataSource>(() => WatchlistRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<WatchlistRepository>(() => WatchlistRepositoryImpl(serviceLocator()))
    ..registerFactory(() => FetchWatchlistStocksWithFinance(serviceLocator()))
    ..registerFactory(() => RemoveFromWatchlist(serviceLocator()))
    ..registerLazySingleton(
      () => WatchlistBloc(
        fetchWatchlistStocksWithFinance: serviceLocator(),
        removeFromWatchlist: serviceLocator(),
      ),
    );
}
