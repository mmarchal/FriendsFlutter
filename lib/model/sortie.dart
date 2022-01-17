import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';

part 'sortie.g.dart';

@JsonSerializable()
class Sortie {
  final int? id;
  final DateTime datePropose;
  final String intitule;
  final String lieu;
  final List<Friend>? friends;

  Sortie(
      {this.id,
      required this.datePropose,
      required this.intitule,
      required this.lieu,
      this.friends});

  factory Sortie.fromJson(Map<String, dynamic> json) => _$SortieFromJson(json);

  Map<String, dynamic> toJson() => _$SortieToJson(this);
}
