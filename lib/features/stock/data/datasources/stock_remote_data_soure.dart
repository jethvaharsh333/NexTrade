import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/stock/data/models/stock_financials_model.dart';
import 'package:nextrade/features/stock/data/models/stock_list_model.dart';
import 'package:nextrade/features/stock/data/models/stock_price_model.dart';

abstract interface class StockRemoteDataSource {
  Future<List<StockListModel>> getStockList({int page, int limit});

  Future<List<StockPriceModel>> getStockPriceBySymbolAndPeriod({required String stockSymbol, required String period});

  Future<StockFinancialsModel> getStockFinancials({required String stockSymbol});

  Future<String> addToWatchlist({required String stockSymbol});

  Future<List<String>?> getWatchlistStocks();

  Future<String> removeStockFromWatchlist({required String stockSymbol});
}

class StockRemoteDataSourceImpl implements StockRemoteDataSource {
  final ApiClient _apiClient;

  StockRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<StockListModel>> getStockList({int page = 1, int limit = 10}) async {
    try {
      print("stock/get-all api called");
      final response = await _apiClient.dio.get("stock/get-all", queryParameters: {"page": page, "limit": limit});
      print("Response: $response");

      if (response.data == null) {
        throw const ServerExceptions('User is null');
      }

      return (response.data as List).map((stock) => StockListModel.fromJson(stock as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<List<StockPriceModel>> getStockPriceBySymbolAndPeriod(
      {required String stockSymbol, required String period}) async {
    try {
      print("stock/price api called, stockSymbol: ${stockSymbol}, period: ${period}");
      final response =
          await _apiClient.dio.get("stock/price", queryParameters: {"stockSymbol": stockSymbol, "period": period});
      print("Response: $response");

      if (response.data == null) {
        throw const ServerExceptions('User is null');
      }

      return (response.data as List).map((stock) => StockPriceModel.fromJson(stock as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<StockFinancialsModel> getStockFinancials({required String stockSymbol}) async {
    try {
      print("stock/price api called, stockSymbol: ${stockSymbol}");
      final response = await _apiClient.dio.get("stock/financials", queryParameters: {"stockSymbol": stockSymbol});
      print("Response: $response");

      if (response.data == null) {
        throw const ServerExceptions('Stock financials is null');
      }
      return StockFinancialsModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<String> addToWatchlist({required String stockSymbol}) async {
    try {
      final data = {
        "stockSymbol": stockSymbol,
      };

      print("watchlist post api called.");
      final response = await _apiClient.dio.post("watchlist", data: data);

      if (response.data == null) {
        throw const ServerExceptions('Not added to watchlist');
      }

      return stockSymbol;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  Future<List<String>?> getWatchlistStocks() async{
    try {
      print("get watchlist stocks list api called.");
      final response = await _apiClient.dio.get("watchlist/get-watchlist-stocks");

      print("RESPONSE: ");
      print(response.data);

      return List<String>.from(response.data);
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
