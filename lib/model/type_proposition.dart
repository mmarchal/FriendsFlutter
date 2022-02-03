import 'package:json_annotation/json_annotation.dart';

part 'type_proposition.g.dart';

@JsonSerializable()
class TypeProposition {
  final int? id;
  final String type;

  TypeProposition({this.id, required this.type});

  factory TypeProposition.fromJson(Map<String, dynamic> json) =>
      _$TypePropositionFromJson(json);

  Map<String, dynamic> toJson() => _$TypePropositionToJson(this);
}
