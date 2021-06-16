part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignIn extends SignInEvent {
  final String username;
  final String password;

  SignIn(this.username, this.password);
}
