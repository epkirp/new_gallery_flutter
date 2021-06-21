import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/entities/login_entity.dart';
import 'package:domain/gateways/authorization_gateway.dart';
import 'package:domain/gateways/shared_preferences_gateway.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final AuthorizationGateway authorizationGateway;
  final SharedPreferencesGateway sharedPreferencesGateway;

  TokenInterceptor({required this.authorizationGateway, required this.sharedPreferencesGateway, required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String _accessToken = sharedPreferencesGateway.getAccessToken();
    if (_accessToken.isNotEmpty) {
      options.headers = {HttpHeaders.authorizationHeader: 'Bearer $_accessToken'};
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if ((err.error as String).contains('401')) {
      String _clientId = sharedPreferencesGateway.getClientId();
      String _clientSecret = sharedPreferencesGateway.getClientSecret();
      String _refreshToken = sharedPreferencesGateway.getRefreshToken();
      LoginEntity tokens = await authorizationGateway.getTokenByRefreshToken(
        clientId: _clientId,
        clientSecret: _clientSecret,
        refreshToken: _refreshToken,
      );

      if (tokens.accessToken.isNotEmpty) {
        await dio.request(
          err.requestOptions.path,
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
          onSendProgress: err.requestOptions.onSendProgress,
          options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer ${tokens.accessToken}'},
          ),
        );
      }
    }

    super.onError(err, handler);
  }
}
