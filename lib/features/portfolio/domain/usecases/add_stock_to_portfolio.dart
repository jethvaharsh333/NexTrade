import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/portfolio/domain/repository/portfolio_repository.dart';

class AddStockToPortfolio implements UseCase<String, AddStockToPortfolioParams> {
  final PortfolioRepository portfolioRepository;
  const AddStockToPortfolio(this.portfolioRepository);

  @override
  Future<Either<Failure, String>> call(AddStockToPortfolioParams params) async {
    return await portfolioRepository.addStockToPortfolio(
      stockSymbol: params.stockSymbol,
      investmentDate: params.investmentDate,
      investmentPrice: params.investmentPrice,
      quantity: params.quantity,
    );
  }
}

class AddStockToPortfolioParams {
  final String stockSymbol;
  final DateTime investmentDate;
  final double investmentPrice;
  final double quantity;

  AddStockToPortfolioParams({
    required this.stockSymbol,
    required this.investmentDate,
    required this.investmentPrice,
    required this.quantity,
  });
}
