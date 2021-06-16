import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  LoginEntity(this.accessToken, this.refreshToken);

  factory LoginEntity.fromJson(Map<String, dynamic> json) => _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
