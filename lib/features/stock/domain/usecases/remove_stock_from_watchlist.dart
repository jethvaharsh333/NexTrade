import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class RemoveStockFromWatchlist implements UseCase<String, RemoveStockFromWatchlistParams>{
  final StockRepository stockRepository;
  RemoveStockFromWatchlist(this.stockRepository);

  @override
  Future<Either<Failure, String>> call(RemoveStockFromWatchlistParams params) async {
    return await stockRepository.removeStockFromWatchlist(stockSymbol: params.stockSymbol);
  }
}

class RemoveStockFromWatchlistParams{
  final String stockSymbol;
  RemoveStockFromWatchlistParams({required this.stockSymbol});
}