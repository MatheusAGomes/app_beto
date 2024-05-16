import 'package:app_beto/models/licaoCompleta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filho.g.dart';

@JsonSerializable()
class Filho {
  int? id;
  String? nome;
  String? foto;
  List<LicaoCompleta?> licoes;

  Filho({this.id, this.nome, required this.licoes, this.foto});

  factory Filho.fromJson(Map<String, dynamic> json) => _$FilhoFromJson(json);

  Map<String, dynamic> toJson() => _$FilhoToJson(this);
}
