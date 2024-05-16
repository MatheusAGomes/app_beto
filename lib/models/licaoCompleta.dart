import 'package:json_annotation/json_annotation.dart';
import 'resposta.dart';

part 'licaoCompleta.g.dart';

@JsonSerializable()
class LicaoCompleta {
  int? numeracao;
  List<Resposta?>? respostas;
  int? estrelas;

  LicaoCompleta({
    this.numeracao,
    this.respostas,
    this.estrelas,
  });

  factory LicaoCompleta.fromJson(Map<String, dynamic> json) =>
      _$LicaoCompletaFromJson(json);
  Map<String, dynamic> toJson() => _$LicaoCompletaToJson(this);
}
