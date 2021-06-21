import 'package:domain/entities/client_entity.dart';
import 'package:domain/entities/login_entity.dart';
import 'package:domain/entities/post/post_client_entity.dart';

abstract class AuthorizationGateway {
  Future<ClientEntity> createClient(PostClientEntity postClient);

  Future<LoginEntity> signIn({
    required String username,
    required String password,
    required String clientId,
    required String clientSecret,
  });

  Future<LoginEntity> getTokenByRefreshToken({
    required String clientId,
    required String clientSecret,
    required String refreshToken,
  });
}
