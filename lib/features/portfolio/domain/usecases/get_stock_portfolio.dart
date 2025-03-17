import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/portfolio/domain/entities/stock_portfolio.dart';
import 'package:nextrade/features/portfolio/domain/repository/portfolio_repository.dart';

class GetStockPortfolio implements UseCase<StockPortfolio, NoParams>{
  final PortfolioRepository portfolioRepository;
  const GetStockPortfolio(this.portfolioRepository);

  @override
  Future<Either<Failure, StockPortfolio>> call(NoParams params) {
    return portfolioRepository.getStockPortfolio();
  }
}