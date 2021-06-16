import 'package:json_annotation/json_annotation.dart';

part 'post_client_entity.g.dart';

@JsonSerializable()
class PostClientEntity {
  final String name;
  final List<String> allowedGrantTypes;

  PostClientEntity(this.name, this.allowedGrantTypes);

  factory PostClientEntity.fromJson(Map<String, dynamic> json) => _$PostClientEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostClientEntityToJson(this);
}
