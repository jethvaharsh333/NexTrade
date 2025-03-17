part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class IndicesLoading extends HomeState{}

final class FetchingIndexSuccess extends HomeState{
  final List<StockIndex> stockIndices;
  FetchingIndexSuccess(this.stockIndices);
}

final class FetchingIndexFailure extends HomeState{
  final String message;
  FetchingIndexFailure(this.message);
}