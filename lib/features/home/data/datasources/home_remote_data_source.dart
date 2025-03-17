import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/home/data/models/stock_index_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<StockIndexModel>> getStockIndices();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource{
  final ApiClient _apiClient;
  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<StockIndexModel>> getStockIndices() async {
    try {
      print("stock/indices api called");
      final response = await _apiClient.dio.get("stock/indices");
      print("Response: $response");

      if (response.data == null) {
        throw const ServerExceptions('No Index found!!');
      }

      return (response.data as List).map((stock) => StockIndexModel.fromJson(stock as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

}