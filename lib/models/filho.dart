import 'package:app_beto/models/licaoCompleta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filho.g.dart';

@JsonSerializable()
class Filho {
  @JsonKey(name: '_id')
  String? id;
  int? idDoFilho;
  String? nome;
  String? foto;
  List<LicaoCompleta?> licaoCompleta;

  Filho({this.idDoFilho, this.nome, required this.licaoCompleta, this.foto});

  factory Filho.fromJson(Map<String, dynamic> json) => _$FilhoFromJson(json);

  Map<String, dynamic> toJson() => _$FilhoToJson(this);
}
