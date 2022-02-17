import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int? id;
  final String content;
  final DateTime deliveredAt;
  final Friend friend;

  Message(
      {this.id,
      required this.content,
      required this.deliveredAt,
      required this.friend});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
