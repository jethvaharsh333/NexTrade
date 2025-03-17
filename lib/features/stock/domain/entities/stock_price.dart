class StockPrice {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  StockPrice({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });



  // Convert object to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     "date": date.toIso8601String(),
  //     "open": open,
  //     "high": high,
  //     "low": low,
  //     "close": close,
  //     "volume": volume,
  //   };
  // }
}
