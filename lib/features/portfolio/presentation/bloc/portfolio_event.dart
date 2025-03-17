part of 'portfolio_bloc.dart';

@immutable
sealed class PortfolioEvent {}

final class AddStockToPortfolioEvent extends PortfolioEvent {
  final String stockSymbol;
  final DateTime investmentDate;
  final double investmentPrice;
  final double quantity;

  AddStockToPortfolioEvent({
    required this.stockSymbol,
    required this.investmentDate,
    required this.investmentPrice,
    required this.quantity,
  });
}

final class GetPortfolioEvent extends PortfolioEvent {}