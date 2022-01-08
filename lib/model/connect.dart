import 'package:json_annotation/json_annotation.dart';

part 'connect.g.dart';

@JsonSerializable()
class Connect {
  final String login;
  final String password;

  Connect(
      {required this.login,
      required this.password});

  factory Connect.fromJson(Map<String, dynamic> json) => _$ConnectFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectToJson(this);
}
