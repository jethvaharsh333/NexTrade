import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/portfolio/domain/entities/stock_portfolio.dart';
import 'package:nextrade/features/portfolio/domain/usecases/add_stock_to_portfolio.dart';
import 'package:nextrade/features/portfolio/domain/usecases/get_stock_portfolio.dart';

part 'portfolio_event.dart';

part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final AddStockToPortfolio _addStockToPortfolio;
  final GetStockPortfolio _getStockPortfolio;

  PortfolioBloc({
    required AddStockToPortfolio addStockToPortfolio,
    required GetStockPortfolio getStockPortfolio,
  })  : _addStockToPortfolio = addStockToPortfolio,
        _getStockPortfolio = getStockPortfolio,
        super(PortfolioInitial()) {
    on<AddStockToPortfolioEvent>(_onAddStockToPortfolio);
    on<GetPortfolioEvent>(_onGetStockPortfolio);
  }

  void _onAddStockToPortfolio(AddStockToPortfolioEvent event, Emitter<PortfolioState> emit) async {
    emit(AddPortfolioLoadingState());

    final res = await _addStockToPortfolio(
      AddStockToPortfolioParams(
        stockSymbol: event.stockSymbol,
        investmentDate: event.investmentDate,
        investmentPrice: event.investmentPrice,
        quantity: event.quantity,
      ),
    );

    res.fold(
      (l) => emit(AddPortfolioFailureState(l.message)),
      (r) {
        add(GetPortfolioEvent());
        emit(AddPortfolioSuccessState(r));
      },
    );
  }

  void _onGetStockPortfolio(GetPortfolioEvent event, Emitter<PortfolioState> emit) async {
    emit(GetPortfolioLoadingState());

    final res = await _getStockPortfolio(NoParams());

    res.fold(
          (l) => emit(GetPortfolioFailureState(l.message)),
          (r) => emit(GetPortfolioSuccessState(r)),
    );
  }
}


