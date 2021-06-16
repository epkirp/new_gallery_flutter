import 'package:json_annotation/json_annotation.dart';

part 'client_entity.g.dart';

@JsonSerializable()
class ClientEntity {
  final int id;
  final String name;
  final String randomId;
  final String secret;

  ClientEntity(this.id, this.name, this.randomId, this.secret);

  factory ClientEntity.fromJson(Map<String, dynamic> json) => _$ClientEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ClientEntityToJson(this);
}
