// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filho.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filho _$FilhoFromJson(Map<String, dynamic> json) => Filho(
      id: (json['id'] as num?)?.toInt(),
      nome: json['nome'] as String?,
      licoes: (json['licoes'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : LicaoCompleta.fromJson(e as Map<String, dynamic>))
          .toList(),
      foto: json['foto'] as String?,
    );

Map<String, dynamic> _$FilhoToJson(Filho instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'foto': instance.foto,
      'licoes': instance.licoes,
    };
