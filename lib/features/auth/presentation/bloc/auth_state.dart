part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final String message;
  const AuthSignUpSuccess(this.message);
}

final class AuthLoginSuccess extends AuthState {
  final User user;
  const AuthLoginSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}