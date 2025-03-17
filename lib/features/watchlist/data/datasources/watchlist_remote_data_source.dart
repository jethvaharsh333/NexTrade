import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/watchlist/data/models/watchlist_stock_model.dart';

abstract interface class WatchlistRemoteDataSource {
  Future<List<WatchlistStockModel>?> getWatchlistStockWithFinance();
  Future<String> removeStockFromWatchlist({required String stockSymbol});
}

class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final ApiClient _apiClient;
  const WatchlistRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<WatchlistStockModel>?> getWatchlistStockWithFinance() async {
    try{
      final response = await _apiClient.dio.get("watchlist/get-watchlist-stocks-with-finance");
      return (response.data as List).map((stock) => WatchlistStockModel.fromJson(stock as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  Future<String> removeStockFromWatchlist({required String stockSymbol}) async {
    try {
      print("Removing stock from watchlist...");
      final response = await _apiClient.dio.delete("watchlist/remove/$stockSymbol");

      if (response.data == null) {
        throw ServerExceptions('Failed to remove stock');
      }

      return stockSymbol;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}