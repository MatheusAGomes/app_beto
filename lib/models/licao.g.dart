// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'licao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Licao _$LicaoFromJson(Map<String, dynamic> json) => Licao(
      exercicios: (json['exercicios'] as List<dynamic>)
          .map((e) => ExercicioSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LicaoToJson(Licao instance) => <String, dynamic>{
      'exercicios': instance.exercicios,
    };
