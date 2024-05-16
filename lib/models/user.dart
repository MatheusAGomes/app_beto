import 'package:json_annotation/json_annotation.dart';

import 'filho.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? nome;
  String? email;
  List<Filho?>? filhos;

  User({this.id, this.nome, this.email, this.filhos});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
