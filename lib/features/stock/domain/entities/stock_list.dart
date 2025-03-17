class StockList {
  final String stockName;
  final String stockSymbol;
  final String faceValue;
  final String? stockImage;
  final String? industry;

  StockList({required this.stockName, required this.stockSymbol, required this.faceValue, this.stockImage, this.industry});
}