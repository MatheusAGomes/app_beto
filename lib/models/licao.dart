import 'package:app_beto/models/exercicio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'licao.g.dart';

@JsonSerializable()
class Licao {
  final List<ExercicioSchema> exercicios;

  Licao({required this.exercicios});

  void adicionarExercicio(ExercicioSchema exercicio) {
    exercicios.add(exercicio);
  }

  void removerExercicio(int indice) {
    exercicios.removeAt(indice);
  }

  factory Licao.fromJson(Map<String, dynamic> json) => _$LicaoFromJson(json);

  Map<String, dynamic> toJson() => _$LicaoToJson(this);
}
