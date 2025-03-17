import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/watchlist/data/datasources/watchlist_remote_data_source.dart';
import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
import 'package:nextrade/features/watchlist/domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource watchlistRemoteDataSource;
  WatchlistRepositoryImpl(this.watchlistRemoteDataSource);

  @override
  Future<Either<Failure, List<WatchlistStock>?>> getWatchlistStocks() async {
    try {
      final stockFinancials = await watchlistRemoteDataSource.getWatchlistStockWithFinance();
      return right(stockFinancials);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeStockFromWatchlist({required String stockSymbol}) async {
    try {
      final symbol = await watchlistRemoteDataSource.removeStockFromWatchlist(
        stockSymbol: stockSymbol,
      );

      if (symbol == null) {
        return left(Failure("Not able to add in watchlist"));
      }

      return right(symbol);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}