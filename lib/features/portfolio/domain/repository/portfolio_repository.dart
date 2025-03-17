import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/portfolio/domain/entities/stock_portfolio.dart';

abstract interface class PortfolioRepository {
  Future<Either<Failure, String>> addStockToPortfolio({
    required String stockSymbol,
    required DateTime investmentDate,
    required double investmentPrice,
    required double quantity,
  });

  Future<Either<Failure, StockPortfolio>> getStockPortfolio();
}
