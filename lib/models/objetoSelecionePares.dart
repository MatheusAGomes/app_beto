import 'package:json_annotation/json_annotation.dart';

part 'objetoSelecionePares.g.dart';

@JsonSerializable()
class ObjetoSelecionePares {
  String? urlimagem;
  String? nome;
  ObjetoSelecionePares({this.nome, this.urlimagem});

  factory ObjetoSelecionePares.fromJson(Map<String, dynamic> json) =>
      _$ObjetoSelecioneParesFromJson(json);

  Map<String, dynamic> toJson() => _$ObjetoSelecioneParesToJson(this);
}
