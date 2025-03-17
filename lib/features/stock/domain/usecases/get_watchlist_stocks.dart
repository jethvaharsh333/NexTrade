import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class GetWatchlistStocks implements UseCase<List<String>?, NoParams>{
  final StockRepository stockRepository;
  GetWatchlistStocks(this.stockRepository);

  @override
  Future<Either<Failure, List<String>?>> call(NoParams params) async {
    return await stockRepository.getWatchlistStocks();
  }
}