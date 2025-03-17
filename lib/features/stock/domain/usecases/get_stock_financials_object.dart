import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class GetStockFinancialsObject implements UseCase<StockFinancials, StockFinancialsParams> {
  final StockRepository stockRepository;
  const GetStockFinancialsObject(this.stockRepository);

  @override
  Future<Either<Failure, StockFinancials>> call(StockFinancialsParams params) async{
    return await stockRepository.getStockFinancials(stockSymbol: params.stockSymbol);
  }
}

class StockFinancialsParams {
  final String stockSymbol;

  StockFinancialsParams({required this.stockSymbol});
}