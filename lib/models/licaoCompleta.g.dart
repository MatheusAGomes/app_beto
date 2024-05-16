// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licaoCompleta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LicaoCompleta _$LicaoCompletaFromJson(Map<String, dynamic> json) =>
    LicaoCompleta(
      numeracao: (json['numeracao'] as num?)?.toInt(),
      respostas: (json['respostas'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Resposta.fromJson(e as Map<String, dynamic>))
          .toList(),
      estrelas: (json['estrelas'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LicaoCompletaToJson(LicaoCompleta instance) =>
    <String, dynamic>{
      'numeracao': instance.numeracao,
      'respostas': instance.respostas,
      'estrelas': instance.estrelas,
    };
