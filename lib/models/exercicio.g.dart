// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercicioSchema _$ExercicioSchemaFromJson(Map<String, dynamic> json) =>
    ExercicioSchema(
      tipo: $enumDecode(_$TipoLicaoEnumEnumMap, json['tipo']),
      titulo: json['titulo'] as String,
      somenteAudio: json['somenteAudio'] as bool,
      imagem: json['imagem'] as String?,
      respostaEsperada: json['respostaEsperada'] as String?,
      possiveisSilabas: (json['possiveisSilabas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      letrasParaExercicio: (json['letrasParaExercicio'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      posicoesSemLetra: (json['posicoesSemLetra'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toInt())
          .toList(),
      respostasEmArray: json['respostasEmArray'] as List<dynamic>?,
    );

Map<String, dynamic> _$ExercicioSchemaToJson(ExercicioSchema instance) =>
    <String, dynamic>{
      'tipo': _$TipoLicaoEnumEnumMap[instance.tipo]!,
      'titulo': instance.titulo,
      'somenteAudio': instance.somenteAudio,
      'imagem': instance.imagem,
      'respostaEsperada': instance.respostaEsperada,
      'possiveisSilabas': instance.possiveisSilabas,
      'posicoesSemLetra': instance.posicoesSemLetra,
      'letrasParaExercicio': instance.letrasParaExercicio,
      'respostasEmArray': instance.respostasEmArray,
    };

const _$TipoLicaoEnumEnumMap = {
  TipoLicaoEnum.JuncaoDeSilabas: 'JuncaoDeSilabas',
  TipoLicaoEnum.SelecionePares: 'SelecionePares',
  TipoLicaoEnum.Reproduza: 'Reproduza',
  TipoLicaoEnum.CompleteAPalavra: 'CompleteAPalavra',
  TipoLicaoEnum.SelecioneImagens: 'SelecioneImagens',
  TipoLicaoEnum.SelecioneTextos: 'SelecioneTextos',
};
