import 'package:json_annotation/json_annotation.dart';

part 'typesortie.g.dart';

@JsonSerializable()
class TypeSortie {
  final int? id;
  final String type;

  TypeSortie({this.id, required this.type});

  factory TypeSortie.fromJson(Map<String, dynamic> json) =>
      _$TypeSortieFromJson(json);

  Map<String, dynamic> toJson() => _$TypeSortieToJson(this);
}
