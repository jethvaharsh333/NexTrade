part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpClickedEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  AuthSignUpClickedEvent({required this.userName, required this.email, required this.password});
}

final class AuthLoginClickedEvent extends AuthEvent {
  final String identifier;
  final String password;

  AuthLoginClickedEvent({required this.identifier, required this.password});
}

final class AuthIsUserLoggedInEvent extends AuthEvent {}

