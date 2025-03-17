class StockIndex {
  final String indexName;
  final double? percentageChange;
  final double? priceChange;

  StockIndex({
    required this.indexName,
    this.percentageChange,
    this.priceChange,
  });
}