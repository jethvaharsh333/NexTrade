import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/stock/data/datasources/stock_remote_data_soure.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource stockRemoteDataSource;

  StockRepositoryImpl(this.stockRemoteDataSource);

  @override
  Future<Either<Failure, List<StockList>>> getStockList({int page = 1, int limit = 10}) async {
    try {
      final stockList = await stockRemoteDataSource.getStockList(page: page, limit: limit);
      if (stockList == null) {
        return left(Failure("No stock listed."));
      }

      return right(stockList);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<StockPrice>>> getStockPriceBySymbolAndPeriod(
      {required String stockSymbol, required String period}) async {
    try {
      final stockPriceList = await stockRemoteDataSource.getStockPriceBySymbolAndPeriod(
        stockSymbol: stockSymbol,
        period: period,
      );

      if (stockPriceList == null) {
        return left(Failure("No stock price."));
      }

      return right(stockPriceList);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, StockFinancials>> getStockFinancials({required String stockSymbol}) async {
    try {
      final stockFinancials = await stockRemoteDataSource.getStockFinancials(
        stockSymbol: stockSymbol,
      );

      if (stockFinancials == null) {
        return left(Failure("No stock price."));
      }

      return right(stockFinancials);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addToWatchlist({required String stockSymbol}) async {
    try {
      final symbol = await stockRemoteDataSource.addToWatchlist(
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

  @override
  Future<Either<Failure, List<String>?>> getWatchlistStocks() async {
    try {
      final symbols = await stockRemoteDataSource.getWatchlistStocks();

      return right(symbols);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeStockFromWatchlist({required String stockSymbol}) async {
    try {
      final symbol = await stockRemoteDataSource.removeStockFromWatchlist(
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

/*
  @override
  Future<Either<Failure, List<StockPrice>>> getStockPriceBySymbolAndPeriod(String stockSymbol, String period) async {
    try{final stockPriceList = await stockRemoteDataSource.getStockPriceBySymbolAndPeriod(stockSymbol, period);
    if (stockPriceList == null){
      return left(Failure("No stock listed."));
    }

    return right(stockPriceList);
  } on ServerExceptions catch (e) {
  return left(Failure(e.message));
  }
  }
  * */
}
