import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class GetStockPriceList implements UseCase<List<StockPrice>, StockListParams> {
  final StockRepository stockRepository;
  const GetStockPriceList(this.stockRepository);

  @override
  Future<Either<Failure, List<StockPrice>>> call(StockListParams params) async {
    return await stockRepository.getStockPriceBySymbolAndPeriod(stockSymbol: params.stockSymbol, period: params.period);
  }
}

class StockListParams {
  final String stockSymbol;
  final String period;

  StockListParams({required this.stockSymbol, required this.period});
}