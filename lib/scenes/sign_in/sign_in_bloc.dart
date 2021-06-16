import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/gateways/authorization_gateway.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthorizationGateway authorizationGateway;

  SignInBloc(this.authorizationGateway) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignIn) {
      yield SignInLoading();
    }
  }
}
