// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      nome: json['nome'] as String?,
      email: json['email'] as String?,
      filhos: (json['filhos'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Filho.fromJson(e as Map<String, dynamic>))
          .toList(),
      senha: json['senha'] as String?,
      tipo: json['tipo'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'nome': instance.nome,
      'email': instance.email,
      'senha': instance.senha,
      'tipo': instance.tipo,
      'filhos': instance.filhos,
    };
