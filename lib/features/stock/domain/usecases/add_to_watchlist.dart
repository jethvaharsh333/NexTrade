import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class AddToWatchList implements UseCase<String, AddToWatchListParams>{
  final StockRepository stockRepository;
  const AddToWatchList(this.stockRepository);

  @override
  Future<Either<Failure, String>> call(AddToWatchListParams params) async{
    return await stockRepository.addToWatchlist(stockSymbol: params.stockSymbol);
  }
}

class AddToWatchListParams{
  final String stockSymbol;

  AddToWatchListParams({required this.stockSymbol});
}