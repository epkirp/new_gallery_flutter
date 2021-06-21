part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInClicked extends SignInEvent {}

class SignUpClicked extends SignInEvent {}

class EmailChanged extends SignInEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends SignInEvent {
  final String password;

  PasswordChanged(this.password);
}
