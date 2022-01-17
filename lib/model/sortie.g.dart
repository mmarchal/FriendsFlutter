// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sortie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sortie _$SortieFromJson(Map<String, dynamic> json) => Sortie(
      id: json['id'] as int?,
      datePropose: DateTime.parse(json['datePropose'] as String),
      intitule: json['intitule'] as String,
      lieu: json['lieu'] as String,
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => Friend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SortieToJson(Sortie instance) => <String, dynamic>{
      'id': instance.id,
      'datePropose': instance.datePropose.toIso8601String(),
      'intitule': instance.intitule,
      'lieu': instance.lieu,
      'friends': instance.friends,
    };
