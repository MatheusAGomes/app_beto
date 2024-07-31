import 'package:json_annotation/json_annotation.dart';
import 'resposta.dart';

part 'licaoCompleta.g.dart';

@JsonSerializable()
class LicaoCompleta {
  String idLicao;
  int indexLicao;
  List<Resposta> respostas;
  int estrelas;
  DateTime? date;

  LicaoCompleta(
      {required this.indexLicao,
      required this.idLicao,
      required this.respostas,
      required this.estrelas,
      this.date});

  factory LicaoCompleta.fromJson(Map<String, dynamic> json) =>
      _$LicaoCompletaFromJson(json);
  Map<String, dynamic> toJson() => _$LicaoCompletaToJson(this);
}
