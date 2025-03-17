part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileEditSuccess extends ProfileState {
  final String message;
  ProfileEditSuccess(this.message);
}

final class PasswordEditSuccess extends ProfileState {
  final String message;
  PasswordEditSuccess(this.message);
}

final class ProfileEditFailure extends ProfileState {
  final String message;
  ProfileEditFailure(this.message);
}

final class PasswordEditFailure extends ProfileState {
  final String message;
  PasswordEditFailure(this.message);
}

// Logout
final class ProfileLogoutLoading extends ProfileState {}

final class ProfileLogoutSuccess extends ProfileState {
  final String successMessage;
  ProfileLogoutSuccess(this.successMessage);
}

final class ProfileLogoutFailure extends ProfileState {
  final String failureMessage;
  ProfileLogoutFailure(this.failureMessage);
}
