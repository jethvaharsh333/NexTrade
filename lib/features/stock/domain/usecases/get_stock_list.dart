import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';
import 'package:nextrade/features/stock/domain/repository/stock_repository.dart';

class GetStockList implements UseCase<List<StockList>, PageLimitParams>{
  final StockRepository stockRepository;
  GetStockList(this.stockRepository);

  @override
  Future<Either<Failure, List<StockList>>> call(PageLimitParams pageLimitParams) {
    return stockRepository.getStockList(page: pageLimitParams.page, limit: pageLimitParams.limit);
  }
}

class PageLimitParams {
  final int page;
  final int limit;

  PageLimitParams({required this.page, required this.limit});
}