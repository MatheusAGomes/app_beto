import 'package:json_annotation/json_annotation.dart';

import 'filho.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String? id;
  String? nome;
  String? email;
  String? senha;
  String? tipo;
  List<Filho?>? filhos;

  User({this.id, this.nome, this.email, this.filhos, this.senha, this.tipo});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
