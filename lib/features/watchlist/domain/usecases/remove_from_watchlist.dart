import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/watchlist/domain/repository/watchlist_repository.dart';

class RemoveFromWatchlist implements UseCase<String, RemoveFromWatchlistParams>{
  final WatchlistRepository watchlistRepository;
  RemoveFromWatchlist(this.watchlistRepository);

  @override
  Future<Either<Failure, String>> call(RemoveFromWatchlistParams params) async {
    return await watchlistRepository.removeStockFromWatchlist(stockSymbol: params.stockSymbol);
  }
}

class RemoveFromWatchlistParams{
  final String stockSymbol;
  RemoveFromWatchlistParams({required this.stockSymbol});
}