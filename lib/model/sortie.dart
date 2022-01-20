import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/typesortie.dart';

part 'sortie.g.dart';

@JsonSerializable()
class Sortie {
  final int? id;
  final DateTime datePropose;
  final String intitule;
  final String lieu;
  final List<Friend>? friends;
  final TypeSortie typeSortie;

  Sortie(
      {this.id,
      required this.datePropose,
      required this.intitule,
      required this.lieu,
      required this.typeSortie,
      this.friends});

  factory Sortie.fromJson(Map<String, dynamic> json) => _$SortieFromJson(json);

  Map<String, dynamic> toJson() => _$SortieToJson(this);
}
