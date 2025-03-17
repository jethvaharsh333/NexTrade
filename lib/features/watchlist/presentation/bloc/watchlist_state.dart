part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistState {}

final class WatchlistInitial extends WatchlistState {}

// Fetch WatchlistStocks with finance
final class FetchWatchlistStocksLoadingState extends WatchlistState {}

final class FetchWatchlistStocksSuccessState extends WatchlistState {
  final List<WatchlistStock>? watchlistStock;
  FetchWatchlistStocksSuccessState(this.watchlistStock);
}

final class FetchWatchlistStocksFailureState extends WatchlistState {
  final String failureMessage;
  FetchWatchlistStocksFailureState(this.failureMessage);
}


// Remove Watchlist Stocks RemoveStockFromWatchlist
final class RemoveFromWatchlistLoadingState extends WatchlistState{}

final class RemoveFromWatchlistSuccessState extends WatchlistState{
  final String stockSymbol;
  RemoveFromWatchlistSuccessState(this.stockSymbol);
}

final class RemoveFromWatchlistFailureState extends WatchlistState{
  final String failureMessage;
  RemoveFromWatchlistFailureState(this.failureMessage);
}