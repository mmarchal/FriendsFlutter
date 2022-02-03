import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/type_proposition.dart';

part 'proposition.g.dart';

@JsonSerializable()
class Proposition {
  final Friend utilisateur;
  final TypeProposition typeProposition;
  final String titre;
  final String detail;

  Proposition(
      {required this.utilisateur,
      required this.typeProposition,
      required this.titre,
      required this.detail});

  factory Proposition.fromJson(Map<String, dynamic> json) =>
      _$PropositionFromJson(json);

  Map<String, dynamic> toJson() => _$PropositionToJson(this);
}
