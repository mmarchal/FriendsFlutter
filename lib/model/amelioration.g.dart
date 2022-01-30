// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amelioration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Amelioration _$AmeliorationFromJson(Map<String, dynamic> json) => Amelioration(
      utilisateur: Friend.fromJson(json['utilisateur'] as Map<String, dynamic>),
      typeProposition:
          $enumDecode(_$TypePropositionEnumMap, json['typeProposition']),
      titre: json['titre'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$AmeliorationToJson(Amelioration instance) =>
    <String, dynamic>{
      'utilisateur': instance.utilisateur,
      'typeProposition': _$TypePropositionEnumMap[instance.typeProposition],
      'titre': instance.titre,
      'detail': instance.detail,
    };

const _$TypePropositionEnumMap = {
  TypeProposition.bug: 'bug',
  TypeProposition.fonctionnalite: 'fonctionnalite',
};
