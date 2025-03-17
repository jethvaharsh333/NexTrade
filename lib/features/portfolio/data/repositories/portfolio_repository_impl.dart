import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:nextrade/features/portfolio/domain/entities/stock_portfolio.dart';
import 'package:nextrade/features/portfolio/domain/repository/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository{
  final PortfolioRemoteDataSource portfolioRemoteDataSource;
  PortfolioRepositoryImpl(this.portfolioRemoteDataSource);

  @override
  Future<Either<Failure, String>> addStockToPortfolio({required String stockSymbol, required DateTime investmentDate, required double investmentPrice, required double quantity}) async {
    try {
      final successMessage = await portfolioRemoteDataSource.addStockToPortfolio(stockSymbol: stockSymbol, investmentDate: investmentDate, investmentPrice: investmentPrice, quantity: quantity);
      return right(successMessage);
    } on ServerExceptions catch (e) {
      print("Sanchoooo");
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, StockPortfolio>> getStockPortfolio() async {
    try{
      final res = await portfolioRemoteDataSource.getStockPortfolio();
      return right(res);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

}