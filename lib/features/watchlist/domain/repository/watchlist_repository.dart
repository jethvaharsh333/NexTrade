import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';

abstract interface class WatchlistRepository {
  Future<Either<Failure, List<WatchlistStock>?>> getWatchlistStocks();

  Future<Either<Failure, String>> removeStockFromWatchlist({
    required String stockSymbol,
  });
}