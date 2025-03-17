import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';
import 'package:nextrade/features/home/domain/entities/stock_index.dart';
import 'package:nextrade/features/home/domain/usecases/get_stock_indices.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetStockIndices _getStockIndices;

  HomeBloc({
    required GetStockIndices getStockIndices,
  })  : _getStockIndices = getStockIndices,
        super(HomeInitial()) {
    // on<HomeEvent>((event, emit) {
      on<FetchingStockIndicesEvent>(_fetchingStockIndicesEvent);
    // });
  }
  
  Future<void> _fetchingStockIndicesEvent(FetchingStockIndicesEvent event, Emitter<HomeState> emit) async {
    emit(IndicesLoading());
    final res = await _getStockIndices(NoParams());
    res.fold((l) => emit(FetchingIndexFailure(l.message)), (stockIndices) => emit(FetchingIndexSuccess(stockIndices)));
    // res.fold((l) => emit(FetchingIndexFailure(l.message)), (user) => _emit(user, emit));
  }
}
