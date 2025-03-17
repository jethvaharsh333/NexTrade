import 'package:nextrade/features/stock/domain/entities/stock_list.dart';

class StockListModel extends StockList {
  StockListModel({
    required super.stockName,
    required super.stockSymbol,
    required super.faceValue,
    super.stockImage,
    super.industry,
  });

  factory StockListModel.fromJson(Map<String, dynamic> map) {
    return StockListModel(
      stockName: map['stockName'] ?? '',
      stockSymbol: map['stockSymbol'] ?? '',
      faceValue: map['faceValue'].toString() ?? '',
      stockImage: map['stockImage'],
      industry: map['industry'],
    );
  }
}
