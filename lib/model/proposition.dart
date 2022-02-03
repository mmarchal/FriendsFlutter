import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/type_proposition.dart';

part 'proposition.g.dart';

@JsonSerializable()
class Proposition {
  final String nom;
  final TypeProposition typeProposition;
  final DateTime dateProposition;
  final String demande;

  Proposition(
      {required this.nom,
      required this.typeProposition,
      required this.dateProposition,
      required this.demande});

  factory Proposition.fromJson(Map<String, dynamic> json) =>
      _$PropositionFromJson(json);

  Map<String, dynamic> toJson() => _$PropositionToJson(this);
}
