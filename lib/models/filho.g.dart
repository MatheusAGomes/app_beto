// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filho.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filho _$FilhoFromJson(Map<String, dynamic> json) => Filho(
      idDoFilho: (json['idDoFilho'] as num?)?.toInt(),
      nome: json['nome'] as String?,
      licaoCompleta: (json['licaoCompleta'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : LicaoCompleta.fromJson(e as Map<String, dynamic>))
          .toList(),
      foto: json['foto'] as String?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$FilhoToJson(Filho instance) => <String, dynamic>{
      '_id': instance.id,
      'idDoFilho': instance.idDoFilho,
      'nome': instance.nome,
      'foto': instance.foto,
      'licaoCompleta': instance.licaoCompleta,
    };
