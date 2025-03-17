part of 'stock_bloc.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}


// Stock List
final class StockListLoading extends StockState {}

final class GetStockListSuccess extends StockState {
  final List<StockList> stocks;
  final int currentPage;

  GetStockListSuccess(this.stocks, this.currentPage);
}

final class GetStockListFailure extends StockState {
  final String errorMessage;
  GetStockListFailure(this.errorMessage);
}


// Stock Price
final class StockPriceLoadingState extends StockState {}

final class GetStockPriceSuccessState extends StockState {
  final List<StockPrice> stockPrices;
  GetStockPriceSuccessState(this.stockPrices);
}

final class GetStockPriceFailureState extends StockState {
  final String errorMessage;
  GetStockPriceFailureState(this.errorMessage);
}


// Stock Financials
final class StockFinancialsLoadingState extends StockState {}

final class StockFinancialsSuccessState extends StockState {
  final StockFinancials stockFinancials;
  StockFinancialsSuccessState(this.stockFinancials);
}

final class StockFinancialsFailureState extends StockState {
  final String errorMessage;
  StockFinancialsFailureState(this.errorMessage);
}

// Add to WatchList
final class AddToWatchlistLoadingState extends StockState{}

final class AddToWatchlistSuccessState extends StockState{
  final String stockSymbol;
  AddToWatchlistSuccessState(this.stockSymbol);
}

final class AddToWatchlistFailureState extends StockState{
  final String failureMessage;
  AddToWatchlistFailureState(this.failureMessage);
}

// Get Watchlist Stocks
final class FetchWatchlistStocksLoadingState extends StockState{}

final class FetchWatchlistStocksSuccessState extends StockState{
  final List<String>? stockSymbols;
  FetchWatchlistStocksSuccessState(this.stockSymbols);
}

final class FetchWatchlistStocksFailureState extends StockState{
  final String failureMessage;
  FetchWatchlistStocksFailureState(this.failureMessage);
}

// Remove Watchlist Stocks RemoveStockFromWatchlist
final class RemoveStockFromWatchlistLoadingState extends StockState{}

final class RemoveStockFromWatchlistSuccessState extends StockState{
  final String stockSymbol;
  RemoveStockFromWatchlistSuccessState(this.stockSymbol);
}

final class RemoveStockFromWatchlistFailureState extends StockState{
  final String failureMessage;
  RemoveStockFromWatchlistFailureState(this.failureMessage);
}