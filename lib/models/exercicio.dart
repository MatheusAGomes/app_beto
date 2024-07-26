import 'package:json_annotation/json_annotation.dart';

import '../shared/enum/tipoDaLicaoEnum.dart';
part 'exercicio.g.dart';

@JsonSerializable()
class ExercicioSchema {
  final TipoLicaoEnum tipo;
  final String titulo;
  final bool somenteAudio;
  final String? imagem;
  final String? respostaEsperada;
  final List<String>? possiveisSilabas;
  final List<int?>? posicoesSemLetra;
  final List<String?>? letrasParaExercicio;
  final List<dynamic>? respostasEmArray;

  ExercicioSchema(
      {required this.tipo,
      required this.titulo,
      required this.somenteAudio,
      this.imagem,
      this.respostaEsperada,
      this.possiveisSilabas,
      this.letrasParaExercicio,
      this.posicoesSemLetra,
      this.respostasEmArray});

  factory ExercicioSchema.fromJson(Map<String, dynamic> json) =>
      _$ExercicioSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$ExercicioSchemaToJson(this);
}
