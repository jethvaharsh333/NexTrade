import 'package:fpdart/fpdart.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';

abstract interface class HomeRepository{
  Future<Either<Failure, List<StockIndex>>> getStockIndices();
}