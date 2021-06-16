import 'package:dio/dio.dart';
import 'package:domain/entities/post/post_client_entity.dart';

abstract class AuthorizationGateway {
  Future<Response<dynamic>> createClient(PostClientEntity postClient);

  Future<Response<dynamic>> signIn({
    required String username,
    required String password,
    required String clientId,
    required String clientSecret,
  });

  Future<Response<dynamic>> getTokenByRefreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
  });
}
