import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';

class WatchlistStockModel extends WatchlistStock {
  WatchlistStockModel(
      {required super.stockSymbol,
      required super.stockName,
       super.faceValue,
       super.stockImage,
      required super.industry,
      required super.currentPrice,
      required super.todaysGainLoss});

  factory WatchlistStockModel.fromJson(Map<String, dynamic> map) {
    return WatchlistStockModel(
      stockSymbol: map["stockSymbol"] ?? "N/A",
      stockName: map["stockName"] ?? "N/A",
      faceValue: map["faceValue"],
      stockImage: map["stockImage"],
      industry: map["industry"] ?? "N/A",
      currentPrice: (map['currentPrice'] as num).toDouble(),
      todaysGainLoss: (map['todaysGainLoss'] as num).toDouble(),
    );
  }
}
