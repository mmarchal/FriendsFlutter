import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/message.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final int id;
  final String name;
  final List<Friend>? friends;
  final List<Message>? messagesList;

  Chat(
      {required this.id,
      required this.name,
      this.friends,
      required this.messagesList});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
