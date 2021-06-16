import 'package:dio/dio.dart';
import 'package:domain/entities/post/post_client_entity.dart';
import 'package:domain/gateways/authorization_gateway.dart';

import 'api_constants.dart';

class DioAuthorizationGateway extends AuthorizationGateway {
  static final Dio dio = Dio();

  @override
  Future<Response<dynamic>> createClient(PostClientEntity postClient) async {
    dio.options.baseUrl = ApiConstants.baseUrl;

    return await dio.post("/clients", data: postClient);
  }

  @override
  Future<Response<dynamic>> getTokenByRefreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
  }) async {
    // TODO: implement getTokenByRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> signIn({
    required String username,
    required String password,
    required String clientId,
    required String clientSecret,
  }) async {
    dio.options.baseUrl = ApiConstants.baseUrl;

    final queryParameters = {
      "username": username,
      "password": password,
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": ApiConstants.grantTypePassword
    };

    return await dio.get("oauth/v2/token", queryParameters: queryParameters);
  }
}
