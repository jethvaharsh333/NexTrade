part of 'portfolio_bloc.dart';

@immutable
sealed class PortfolioState {}

final class PortfolioInitial extends PortfolioState {}

// Add Stock to Portfolio
final class AddPortfolioLoadingState extends PortfolioState{}

final class AddPortfolioSuccessState extends PortfolioState{
  final String message;
  AddPortfolioSuccessState(this.message);
}

final class AddPortfolioFailureState extends PortfolioState{
  final String message;
  AddPortfolioFailureState(this.message);
}

// get stocks of portfolio
final class GetPortfolioLoadingState extends PortfolioState{}

final class GetPortfolioSuccessState extends PortfolioState{
  final StockPortfolio stockPortfolio;
  GetPortfolioSuccessState(this.stockPortfolio);
}

final class GetPortfolioFailureState extends PortfolioState{
  final String message;
  GetPortfolioFailureState(this.message);
}