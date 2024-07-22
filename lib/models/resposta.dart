import 'package:json_annotation/json_annotation.dart';

part 'resposta.g.dart';

@JsonSerializable()
class Resposta {
  final List<dynamic> resposta;

  Resposta({required this.resposta});

  // Método gerado para converter JSON em um objeto Resposta
  factory Resposta.fromJson(Map<String, dynamic> json) =>
      _$RespostaFromJson(json);

  // Método gerado para converter um objeto Resposta em JSON
  Map<String, dynamic> toJson() => _$RespostaToJson(this);
}
