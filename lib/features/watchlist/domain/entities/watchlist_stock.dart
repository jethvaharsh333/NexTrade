class WatchlistStock {
  final String stockSymbol;
  final String stockName;
  final int? faceValue;
  final String? stockImage;
  final String industry;
  final double currentPrice;
  final double todaysGainLoss;

  WatchlistStock({required this.stockSymbol, required this.stockName, this.faceValue, this.stockImage, required this.industry, required this.currentPrice, required this.todaysGainLoss});
}