import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/watchlist/domain/entities/watchlist_stock.dart';
import 'package:nextrade/features/watchlist/domain/usecases/fetch_watchlist_stocks_with_finance.dart';
import 'package:nextrade/features/watchlist/domain/usecases/remove_from_watchlist.dart';
// import 'package:nextrade/features/watchlist/domain/usecases/remove_from_watchlist.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final FetchWatchlistStocksWithFinance _fetchWatchlistStocksWithFinance;
  final RemoveFromWatchlist _removeFromWatchlist;

  WatchlistBloc({
    required FetchWatchlistStocksWithFinance fetchWatchlistStocksWithFinance,
    required RemoveFromWatchlist removeFromWatchlist,
  })  : _fetchWatchlistStocksWithFinance = fetchWatchlistStocksWithFinance,
        _removeFromWatchlist = removeFromWatchlist,
        super(WatchlistInitial()) {
    on<FetchWatchlistStocksWithFinanceEvent>(_onFetchWatchlistStocksWithFinance);
    on<RemoveFromWatchlistEvent>(_onRemoveFromWatchlist);
  }

  void _onFetchWatchlistStocksWithFinance(
    FetchWatchlistStocksWithFinanceEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(FetchWatchlistStocksLoadingState());
    final result = await _fetchWatchlistStocksWithFinance(NoParams());
    result.fold((failure) => emit(FetchWatchlistStocksFailureState(failure.message)), (watchlistStocks) => emit(FetchWatchlistStocksSuccessState(watchlistStocks)));
  }

  void _onRemoveFromWatchlist(RemoveFromWatchlistEvent event, Emitter<WatchlistState> emit) async {
    emit(RemoveFromWatchlistLoadingState());
    final result = await _removeFromWatchlist(RemoveFromWatchlistParams(stockSymbol: event.stockSymbol));

    result.fold(
          (l) => emit(RemoveFromWatchlistFailureState(l.message)),
          (_) {
        // favoriteStockSymbols.remove(event.stockSymbol);
            emit(RemoveFromWatchlistSuccessState(event.stockSymbol));
            add(FetchWatchlistStocksWithFinanceEvent());
          },
    );
  }
}
