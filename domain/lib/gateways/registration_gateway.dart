import 'package:domain/entities/user_entity.dart';

abstract class RegistrationGateway {
  Future<void> createUser(UserEntity user);
}
