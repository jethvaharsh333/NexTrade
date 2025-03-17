part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileEditClickedEvent extends ProfileEvent {
  final String name;
  final String userName;
  final String email;
  final String phoneNumber;

  ProfileEditClickedEvent({required this.name, required this.userName, required this.email, required this.phoneNumber});
}

final class PasswordEditClickedEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  PasswordEditClickedEvent({required this.currentPassword, required this.newPassword, required this.confirmPassword});
}

final class ProfileLogoutClickedEvent extends ProfileEvent {
  final String userName;
  final String email;

  ProfileLogoutClickedEvent({required this.userName, required this.email});
}