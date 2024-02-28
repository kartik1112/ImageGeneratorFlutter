part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class OnSignInButtonClickedEvent extends AuthEvent {
  final String username;
  final String password;

  OnSignInButtonClickedEvent({required this.username, required this.password});
}

class OnSignUpButtonClickedEvent extends AuthEvent {
  final String password;
  final String name;
  final String email;

  OnSignUpButtonClickedEvent(
      {required this.name, required this.email, required this.password});
}

class OnSignUpChangeStateButtonClickedEvent extends AuthEvent {}

class OnSignInWithGoogleButtonClickedEvent extends AuthEvent {}
