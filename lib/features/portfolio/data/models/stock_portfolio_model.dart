import 'package:nextrade/features/portfolio/domain/entities/stock_portfolio.dart';

class StockPortfolioModel extends StockPortfolio {
  StockPortfolioModel({
    super.portfolio,
    super.summary,
  });

  factory StockPortfolioModel.fromJson(Map<String, dynamic> map) {
    return StockPortfolioModel(
      portfolio: (map['portfolio'] as List<dynamic>?)?.map((e) => SingleStockPortfolioModel.fromJson(e)).toList(),
      summary: map['summary'] != null ? PortfolioSummaryModel.fromJson(map['summary']) : null,
    );
  }
}

class SingleStockPortfolioModel extends SingleStockPortfolio {
  SingleStockPortfolioModel({
    required super.stockSymbol,
    required super.stockName,
    required super.investmentDate,
    required super.investmentPrice,
    required super.quantity,
    required super.currentPrice,
    required super.todaysGainLoss,
    required super.absoluteGainLoss,
  });

  factory SingleStockPortfolioModel.fromJson(Map<String, dynamic> map) {
    return SingleStockPortfolioModel(
      stockSymbol: map['stockSymbol'],
      stockName: map['stockName'],
      investmentDate: DateTime.parse(map['investmentDate']),
      investmentPrice: (map['investmentPrice'] as num).toDouble(),
      quantity: (map['quantity'] as num).toDouble(),
      currentPrice: (map['currentPrice'] as num).toDouble(),
      todaysGainLoss: (map['todaysGainLoss'] as num).toDouble(),
      absoluteGainLoss: (map['absoluteGainLoss'] as num).toDouble(),
    );
  }
}

class PortfolioSummaryModel extends PortfolioSummary {
  PortfolioSummaryModel({
    required super.totalInvestment,
    required super.totalCurrentValue,
    required super.totalGainLoss,
  });

  factory PortfolioSummaryModel.fromJson(Map<String, dynamic> map) {
    return PortfolioSummaryModel(
      totalInvestment: (map['totalInvestment'] as num).toDouble(),
      totalCurrentValue: (map['totalCurrentValue'] as num).toDouble(),
      totalGainLoss: (map['totalGainLoss'] as num).toDouble(),
    );
  }
}
