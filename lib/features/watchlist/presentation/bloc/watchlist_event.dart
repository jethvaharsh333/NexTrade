part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistEvent {}

final class FetchWatchlistStocksWithFinanceEvent extends WatchlistEvent {}

final class RemoveFromWatchlistEvent extends WatchlistEvent {
  final String stockSymbol;
  RemoveFromWatchlistEvent({required this.stockSymbol});
}