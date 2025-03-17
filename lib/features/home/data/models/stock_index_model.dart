import 'package:nextrade/features/home/domain/entities/stock_index.dart';

class StockIndexModel extends StockIndex {
  StockIndexModel({
    required super.indexName,
    super.percentageChange,
    super.priceChange,
  });

  factory StockIndexModel.fromJson(Map<String, dynamic> map) {
    return StockIndexModel(
      indexName: map["indexName"] ?? "",
      percentageChange: (map["percentageChange"] as num?)?.toDouble(),
      priceChange: (map["priceChange"] as num?)?.toDouble(),
    );
  }
}
