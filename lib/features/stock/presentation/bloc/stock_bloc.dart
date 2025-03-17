import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nextrade/core/error/exceptions.dart';
import 'package:nextrade/core/error/failure.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/stock/domain/entities/stock_financials.dart';
import 'package:nextrade/features/stock/domain/entities/stock_list.dart';
import 'package:nextrade/features/stock/domain/entities/stock_price.dart';
import 'package:nextrade/features/stock/domain/usecases/add_to_watchlist.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_financials_object.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_list.dart';
import 'package:nextrade/features/stock/domain/usecases/get_stock_price_list.dart';
import 'package:nextrade/features/stock/domain/usecases/get_watchlist_stocks.dart';
import 'package:nextrade/features/stock/domain/usecases/remove_stock_from_watchlist.dart';

part 'stock_event.dart';

part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetStockList _getStockList;
  final GetStockPriceList _getStockPriceList;
  final GetStockFinancialsObject _getStockFinancialsObject;
  final AddToWatchList _addToWatchList;
  final GetWatchlistStocks _getWatchlistStocks;
  final RemoveStockFromWatchlist _removeStockFromWatchlist;

  List<StockList> allStocks = [];
  Set<String> favoriteStockSymbols = {};
  int currentPage = 1;

  StockBloc({
    required GetStockList getStockList,
    required GetStockPriceList getStockPriceList,
    required GetStockFinancialsObject getStockFinancialsObject,
    required AddToWatchList addToWatchList,
    required GetWatchlistStocks getWatchlistStocks,
    required RemoveStockFromWatchlist removeStockFromWatchlist,
  })  : _getStockList = getStockList,
        _getStockPriceList = getStockPriceList,
        _getStockFinancialsObject = getStockFinancialsObject,
        _addToWatchList = addToWatchList,
        _getWatchlistStocks = getWatchlistStocks,
        _removeStockFromWatchlist = removeStockFromWatchlist,
        super(StockInitial()) {
    on<FetchStockList>(_onFetchStockList);
    on<FetchStockPriceEvent>(_onFetchStockPriceEvent);
    on<FetchStockFinancialsEvent>(_fetchStockFinancialsEvent);
    on<AddToWatchlistEvent>(_onAddToWatchlist);
    on<FetchWatchlistStocksEvent>(_onFetchWatchlistStocks);
    on<RemoveStockFromWatchlistEvent>(_onRemoveFromWatchlist);
  }

  void _onFetchStockPriceEvent(FetchStockPriceEvent event, Emitter<StockState> emit) async {
    emit(StockPriceLoadingState());
    final res = await _getStockPriceList(StockListParams(
      stockSymbol: event.stockSymbol,
      period: event.period,
    ));
    res.fold(
      (l) => emit(GetStockPriceFailureState(l.message)),
      (stockPrices) => emit(GetStockPriceSuccessState(stockPrices)),
    );
  }

  void _fetchStockFinancialsEvent(FetchStockFinancialsEvent event, Emitter<StockState> emit) async {
    emit(StockFinancialsLoadingState());

    final res = await _getStockFinancialsObject(StockFinancialsParams(
      stockSymbol: event.stockSymbol,
    ));

    res.fold(
      (l) => emit(StockFinancialsFailureState(l.message)),
      (stockFinancials) => emit(StockFinancialsSuccessState(stockFinancials)),
    );
  }

  Future<void> _onFetchStockList(FetchStockList event, Emitter<StockState> emit) async {
    emit(StockListLoading());

    final result = await _getStockList(PageLimitParams(page: event.page, limit: event.limit));

    result.fold(
      (failure) => emit(GetStockListFailure(_mapFailureToMessage(failure))),
      (stocks) {
        allStocks.addAll(stocks);
        currentPage = event.page;
        emit(GetStockListSuccess(List.from(allStocks), currentPage));
      },
    );
  }

  void _onAddToWatchlist(AddToWatchlistEvent event, Emitter<StockState> emit) async {
    emit(AddToWatchlistLoadingState());

    final result = await _addToWatchList(AddToWatchListParams(stockSymbol: event.stockSymbol));

    result.fold(
      (l) => emit(AddToWatchlistFailureState(l.message)),
          (_) {
        favoriteStockSymbols.add(event.stockSymbol);
        emit(AddToWatchlistSuccessState(event.stockSymbol));
      },
    );
  }

  void _onFetchWatchlistStocks(FetchWatchlistStocksEvent event, Emitter<StockState> emit) async {
    emit(FetchWatchlistStocksLoadingState());

    final res = await _getWatchlistStocks(NoParams());

    res.fold(
      (l) => emit(FetchWatchlistStocksFailureState(l.message)),
          (stockSymbols) {
        favoriteStockSymbols = stockSymbols!.toSet(); // might be error
        emit(FetchWatchlistStocksSuccessState(stockSymbols));
      },
    );
  }

  void _onRemoveFromWatchlist(RemoveStockFromWatchlistEvent event, Emitter<StockState> emit) async {
    emit(RemoveStockFromWatchlistLoadingState());
    final result = await _removeStockFromWatchlist(RemoveStockFromWatchlistParams(stockSymbol: event.stockSymbol));

    result.fold(
          (l) => emit(RemoveStockFromWatchlistFailureState(l.message)),
          (_) {
        favoriteStockSymbols.remove(event.stockSymbol);
        emit(RemoveStockFromWatchlistSuccessState(event.stockSymbol));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerExceptions) {
      return "Server error occurred. Please try again later.";
    }
    return "Something went wrong.";
  }
}
