import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nextrade/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nextrade/core/common/entities/user.dart';
import 'package:nextrade/core/usecase/usecase.dart';
import 'package:nextrade/features/auth/domain/usecases/current_user.dart';
import 'package:nextrade/features/auth/domain/usecases/user_login.dart';
import 'package:nextrade/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';
/*
 => if we use required keyword then there will be no new instances means no initializing with constructor
* */
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp=userSignUp,            // mapping userSignUp with variable which got (as required)
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {

    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpClickedEvent>(_onAuthSignUp);
    on<AuthLoginClickedEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUpClickedEvent event, Emitter<AuthState> emit) async {
      final res = await _userSignUp(UserSignUpParams(userName: event.userName, email: event.email, password: event.password));
      res.fold((l) => emit(AuthFailure(l.message)), (successMessage) => emit(AuthSignUpSuccess(successMessage)));
  }

  void _onAuthLogin(AuthLoginClickedEvent event, Emitter<AuthState> emit) async {
      final res = await _userLogin(UserLoginParams(identifier: event.identifier, password: event.password));
      res.fold((l) => emit(AuthFailure(l.message)), (user) => _emitAuthSuccess(user, emit));
  }

  void _isUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async{
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(l.message)), (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthLoginSuccess(user));
  }
}
