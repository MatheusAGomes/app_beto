// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licaoCompleta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LicaoCompleta _$LicaoCompletaFromJson(Map<String, dynamic> json) =>
    LicaoCompleta(
      indexLicao: (json['indexLicao'] as num).toInt(),
      idLicao: json['idLicao'] as String,
      respostas: (json['respostas'] as List<dynamic>)
          .map((e) => Resposta.fromJson(e as Map<String, dynamic>))
          .toList(),
      estrelas: (json['estrelas'] as num).toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$LicaoCompletaToJson(LicaoCompleta instance) =>
    <String, dynamic>{
      'idLicao': instance.idLicao,
      'indexLicao': instance.indexLicao,
      'respostas': instance.respostas,
      'estrelas': instance.estrelas,
      'date': instance.date?.toIso8601String(),
    };
