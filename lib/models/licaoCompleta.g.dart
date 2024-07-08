// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licaoCompleta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LicaoCompleta _$LicaoCompletaFromJson(Map<String, dynamic> json) =>
    LicaoCompleta(
      idLicao: json['idLicao'] as String,
      respostas: (json['respostas'] as List<dynamic>)
          .map((e) => Resposta.fromJson(e as Map<String, dynamic>))
          .toList(),
      estrelas: (json['estrelas'] as num).toInt(),
    );

Map<String, dynamic> _$LicaoCompletaToJson(LicaoCompleta instance) =>
    <String, dynamic>{
      'idLicao': instance.idLicao,
      'respostas': instance.respostas,
      'estrelas': instance.estrelas,
    };
