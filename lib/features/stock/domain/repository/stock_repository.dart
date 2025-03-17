import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';

abstract interface class StockRepository {
  Future<Either<Failure, List<StockList>>> getStockList({int page, int limit});

  Future<Either<Failure, List<StockPrice>>> getStockPriceBySymbolAndPeriod({
    required String stockSymbol,
    required String period,
  });

  Future<Either<Failure, StockFinancials>> getStockFinancials({
    required String stockSymbol,
  });

  Future<Either<Failure, String>> addToWatchlist({
    required String stockSymbol,
  });

  Future<Either<Failure, List<String>?>> getWatchlistStocks();

  Future<Either<Failure, String>> removeStockFromWatchlist({
    required String stockSymbol,
  });
}
