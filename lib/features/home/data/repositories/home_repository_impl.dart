import 'package:fpdart/src/either.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/features/home/data/datasources/home_remote_data_source.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';
import 'package:nextrade/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<StockIndex>>> getStockIndices() async {
    try{
      print("SANCHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      final res = await homeRemoteDataSource.getStockIndices();
      return right(res);
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}