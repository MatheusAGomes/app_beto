import 'package:json_annotation/json_annotation.dart';
import 'resposta.dart';

part 'licaoCompleta.g.dart';

@JsonSerializable()
class LicaoCompleta {
  String id;
  List<Resposta?> respostas;
  int estrelas;

  LicaoCompleta({
    required this.id,
    required this.respostas,
    required this.estrelas,
  });

  factory LicaoCompleta.fromJson(Map<String, dynamic> json) =>
      _$LicaoCompletaFromJson(json);
  Map<String, dynamic> toJson() => _$LicaoCompletaToJson(this);
}
