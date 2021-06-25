import 'package:dio/dio.dart';
import 'package:domain/entities/client_entity.dart';
import 'package:domain/entities/login_entity.dart';
import 'package:domain/entities/post/post_client_entity.dart';
import 'package:domain/gateways/authorization_gateway.dart';
import 'package:gateway/dio/base_dio_request.dart';

import '../api_constants.dart';

class DioAuthorizationGateway extends AuthorizationGateway {
  final Dio dio;

  DioAuthorizationGateway(this.dio);

  @override
  Future<ClientEntity> createClient(PostClientEntity postClient) async {
    return ApiErrorHandler.sendRequest<ClientEntity>(
      request: dio.post("api/clients", data: postClient),
      converter: (json) => ClientEntity.fromJson(json),
    );
  }

  @override
  Future<LoginEntity> signIn({
    required String username,
    required String password,
    required String clientId,
    required String clientSecret,
  }) async {
    final queryParameters = {
      "username": username,
      "password": password,
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": ApiConstants.grantTypePassword
    };

    return ApiErrorHandler.sendRequest<LoginEntity>(
      request: dio.get("oauth/v2/token", queryParameters: queryParameters),
      converter: (json) => LoginEntity.fromJson(json),
    );
  }

  @override
  Future<LoginEntity> getTokenByRefreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
  }) async {
    final queryParameters = {
      "client_id": clientId,
      "client_secret": clientSecret,
      "refresh_token": refreshToken,
      "grant_type": ApiConstants.grantTypePassword
    };

    return ApiErrorHandler.sendRequest<LoginEntity>(
      request: dio.get("oauth/v2/token", queryParameters: queryParameters),
      converter: (json) => LoginEntity.fromJson(json),
    );
  }
}
