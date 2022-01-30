import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';

part 'amelioration.g.dart';

@JsonSerializable()
class Amelioration {
  final Friend utilisateur;
  final TypeProposition typeProposition;
  final String titre;
  final String detail;

  Amelioration(
      {required this.utilisateur,
      required this.typeProposition,
      required this.titre,
      required this.detail});
}

enum TypeProposition { bug, fonctionnalite }
