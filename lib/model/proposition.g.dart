// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proposition _$PropositionFromJson(Map<String, dynamic> json) => Proposition(
      nom: json['nom'] as String,
      typeProposition: TypeProposition.fromJson(
          json['typeProposition'] as Map<String, dynamic>),
      dateProposition: DateTime.parse(json['dateProposition'] as String),
      demande: json['demande'] as String,
    );

Map<String, dynamic> _$PropositionToJson(Proposition instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'typeProposition': instance.typeProposition,
      'dateProposition': instance.dateProposition.toIso8601String(),
      'demande': instance.demande,
    };
