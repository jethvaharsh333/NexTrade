import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
import 'package:nextrade/features/watchlist/domain/repository/watchlist_repository.dart';

class FetchWatchlistStocksWithFinance implements UseCase<List<WatchlistStock>?, NoParams>{
  final WatchlistRepository watchlistRepository;
  FetchWatchlistStocksWithFinance(this.watchlistRepository);

  @override
  Future<Either<Failure, List<WatchlistStock>?>> call(NoParams params) async {
    return await watchlistRepository.getWatchlistStocks();
  }
}