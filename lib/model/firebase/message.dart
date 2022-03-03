import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String from;
  String to;
  String text;
  String imageUrl;
  String dateString;

  Message({
    required this.from,
    required this.to,
    required this.text,
    required this.imageUrl,
    required this.dateString,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
