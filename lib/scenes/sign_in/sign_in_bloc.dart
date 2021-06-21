import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/entities/post/post_client_entity.dart';
import 'package:domain/gateways/authorization_gateway.dart';
import 'package:domain/gateways/shared_preferences_gateway.dart';
import 'package:gateway/api_constants.dart';
import 'package:meta/meta.dart';
import 'package:new_gallery/inputs/input_fields.dart';
import 'package:new_gallery/resources/app_strings.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthorizationGateway authorizationGateway;
  final SharedPreferencesGateway sharedPreferencesGateway;
  String _email = "";
  String _password = "";

  SignInBloc(this.authorizationGateway, this.sharedPreferencesGateway) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      _email = event.email;
    }

    if (event is PasswordChanged) {
      _password = event.password;
    }

    if (event is SignUpClicked) {
      yield OpenSignUpScreen();
    }

    try {
      if (event is SignInClicked) {
        bool hasErrors = false;
        if (_email.isEmpty) {
          hasErrors = true;
          yield SignInInitial(field: InputFields.email, errorMessage: AppStrings.emptyFiled);
        }

        if (!hasErrors) {
          yield SignInLoading();
          final client = await authorizationGateway.createClient(
            PostClientEntity(
              _email,
              [ApiConstants.grantTypePassword, ApiConstants.grantTypeRefreshToken],
            ),
          );
          final String clientId = client.id.toString() + "_" + client.randomId;
          await sharedPreferencesGateway.saveClientData(clientId: clientId, clientSecret: client.secret);
          final tokens = await authorizationGateway.signIn(
            username: _email,
            password: _password,
            clientId: clientId,
            clientSecret: client.secret,
          );
          await sharedPreferencesGateway.saveTokens(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken);
          yield SignInSuccess();
          yield SignInFinishLoading();
        }
      }
    } catch (e) {
      //yield SignInError();
      yield SignInFinishLoading();
    }
  }
}
