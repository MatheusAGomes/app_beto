import 'package:json_annotation/json_annotation.dart';

import '../shared/enum/tipoDaLicaoEnum.dart';

part 'exercicio.g.dart';

@JsonSerializable()
class ExercicioSchema {
  final TipoLicaoEnum tipo;
  final String titulo;
  final bool somenteAudio;
  final String? imagem;
  final String respostaEsperada;
  final List<String>? possiveisSilabas;
  final List<String?>? respostaSemLetras;
  final List<String?>? letrasParaExercicio;

  ExercicioSchema(
      {required this.tipo,
      required this.titulo,
      required this.somenteAudio,
      this.imagem,
      required this.respostaEsperada,
      this.possiveisSilabas,
      this.letrasParaExercicio,
      this.respostaSemLetras});

  factory ExercicioSchema.fromJson(Map<String, dynamic> json) =>
      _$ExercicioSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$ExercicioSchemaToJson(this);
}
