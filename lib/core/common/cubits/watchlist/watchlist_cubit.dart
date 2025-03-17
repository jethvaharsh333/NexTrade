import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistInitial());
}
