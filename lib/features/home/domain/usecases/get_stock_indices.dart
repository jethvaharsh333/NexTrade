import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';
import 'package:nextrade/features/home/domain/repository/home_repository.dart';

class GetStockIndices implements UseCase<List<StockIndex>, NoParams>{
  final HomeRepository homeRepository;
  GetStockIndices(this.homeRepository);

  @override
  Future<Either<Failure, List<StockIndex>>> call(NoParams noParams) async {
    print("KAIDOOOOOOOOOOOOOOOO NO OMEGA");
    return await homeRepository.getStockIndices();
  }
}