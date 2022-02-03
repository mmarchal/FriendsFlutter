// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proposition _$PropositionFromJson(Map<String, dynamic> json) => Proposition(
      utilisateur: Friend.fromJson(json['utilisateur'] as Map<String, dynamic>),
      typeProposition: TypeProposition.fromJson(
          json['typeProposition'] as Map<String, dynamic>),
      titre: json['titre'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$PropositionToJson(Proposition instance) =>
    <String, dynamic>{
      'utilisateur': instance.utilisateur,
      'typeProposition': instance.typeProposition,
      'titre': instance.titre,
      'detail': instance.detail,
    };
