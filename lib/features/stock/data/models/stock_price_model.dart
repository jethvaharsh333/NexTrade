import 'package:nextrade/features/stock/domain/entities/stock_price.dart';

class StockPriceModel extends StockPrice {
  StockPriceModel({
    required super.date,
    required super.open,
    required super.high,
    required super.low,
    required super.close,
    required super.volume,
  });

  factory StockPriceModel.fromJson(Map<String, dynamic> map) {
    return StockPriceModel(
      date: DateTime.parse(map["date"]),
      open: (map["open"] as num).toDouble(),
      high: (map["high"] as num).toDouble(),
      low: (map["low"] as num).toDouble(),
      close: (map["close"] as num).toDouble(),
      volume: (map["volume"] as num).toDouble(),
    );
  }

/*
  factory StockPrice.fromJson(Map<String, dynamic> json) {
  return StockPrice(
    date: json["date"] != null ? DateTime.tryParse(json["date"]) ?? DateTime(2025) : DateTime(2025),
    open: json["open"] != null ? (json["open"] as num).toDouble() : 0.0,
    high: json["high"] != null ? (json["high"] as num).toDouble() : 0.0,
    low: json["low"] != null ? (json["low"] as num).toDouble() : 0.0,
    close: json["close"] != null ? (json["close"] as num).toDouble() : 0.0,
    volume: json["volume"] != null ? json["volume"] as int : 0,
  );
}
  * */
}
