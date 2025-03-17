class StockPortfolio {
  final List<SingleStockPortfolio>? portfolio;
  final PortfolioSummary? summary;

  StockPortfolio({
    this.portfolio,
    this.summary,
  });
}
class SingleStockPortfolio {
  final String stockSymbol;
  final String stockName;
  final DateTime investmentDate;
  final double investmentPrice;
  final double quantity;
  final double currentPrice;
  final double todaysGainLoss;
  final double absoluteGainLoss;

  SingleStockPortfolio({
    required this.stockSymbol,
    required this.stockName,
    required this.investmentDate,
    required this.investmentPrice,
    required this.quantity,
    required this.currentPrice,
    required this.todaysGainLoss,
    required this.absoluteGainLoss,
  });
}

class PortfolioSummary {
  final double totalInvestment;
  final double totalCurrentValue;
  final double totalGainLoss;

  PortfolioSummary({
    required this.totalInvestment,
    required this.totalCurrentValue,
    required this.totalGainLoss,
  });
}