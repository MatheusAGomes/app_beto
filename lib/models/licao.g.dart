// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Licao _$LicaoFromJson(Map<String, dynamic> json) => Licao(
      numeracao: (json['numeracao'] as num?)?.toInt(),
      exercicios: (json['exercicios'] as List<dynamic>)
          .map((e) => ExercicioSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LicaoToJson(Licao instance) => <String, dynamic>{
      'numeracao': instance.numeracao,
      'exercicios': instance.exercicios,
    };
