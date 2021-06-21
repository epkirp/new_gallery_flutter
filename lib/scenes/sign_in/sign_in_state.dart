part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {
  final InputFields? field;
  final String? errorMessage;

  SignInInitial({this.field, this.errorMessage});
}

class SignInLoading extends SignInState {}

class SignInFinishLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {}

class OpenSignUpScreen extends SignInState {}
