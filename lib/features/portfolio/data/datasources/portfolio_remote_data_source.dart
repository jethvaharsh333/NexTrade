import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/network/api_client.dart';
import 'package:nextrade/features/portfolio/data/models/stock_portfolio_model.dart';

abstract interface class PortfolioRemoteDataSource {
  Future<String> addStockToPortfolio({
    required String stockSymbol,
    required DateTime investmentDate,
    required double investmentPrice,
    required double quantity,
  });

  Future<StockPortfolioModel> getStockPortfolio();
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource{
  final ApiClient _apiClient;
  const PortfolioRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> addStockToPortfolio({required String stockSymbol, required DateTime investmentDate, required double investmentPrice, required double quantity}) async {
    try {
      final data = {
        "stockSymbol": stockSymbol,
        "investmentDate": investmentDate.toIso8601String(),
        "investmentPrice": investmentPrice,
        "quantity": quantity
      };

      print(data);

      print("portfolio/add-stock-to-portfolio api called.");
      final response = await _apiClient.dio.post("portfolio/add-stock-to-portfolio", data: data);
      if (response.data == null) {
        throw const ServerExceptions('Unable to add stock in portfolio');
      }
      print("RESPONSE: ${response.data}");
      return response.data.toString();
    } catch (e) {
      print("Err: ${e.toString()}");
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<StockPortfolioModel> getStockPortfolio() async {
    try{
      print("portfolio/get-user-stocks-in-portfolio api called.");
      final response = await _apiClient.dio.get("portfolio/get-user-stocks-in-portfolio");
      if (response.data == "null") {
        print("Kaidoooo");
        throw const ServerExceptions('No stock in portfolio');
      }
      print("RESPONSE: ${response.data}");

      return StockPortfolioModel.fromJson(response.data);
    } catch(e) {
      print("Err: ${e.toString()}");
      throw ServerExceptions(e.toString());
    }
  }
}