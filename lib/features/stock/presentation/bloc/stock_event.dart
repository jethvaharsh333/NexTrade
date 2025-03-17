part of 'stock_bloc.dart';

@immutable
sealed class StockEvent {}

final class FetchStockList extends StockEvent {
  final int page;
  final int limit;

  FetchStockList({this.page = 1, this.limit = 10});
}

final class FetchStockPriceEvent extends StockEvent {
  final String stockSymbol;
  final String period;

  FetchStockPriceEvent({required this.stockSymbol, required this.period});
}

final class FetchStockFinancialsEvent extends StockEvent {
  final String stockSymbol;
  FetchStockFinancialsEvent({required this.stockSymbol});
}

final class AddToWatchlistEvent extends StockEvent {
  final String stockSymbol;
  AddToWatchlistEvent({required this.stockSymbol});
}

final class FetchWatchlistStocksEvent extends StockEvent {}

final class RemoveStockFromWatchlistEvent extends StockEvent {
  final String stockSymbol;
  RemoveStockFromWatchlistEvent({required this.stockSymbol});
}