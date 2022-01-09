import 'package:json_annotation/json_annotation.dart';

part 'connect.g.dart';

@JsonSerializable()
class Connect {
  final String username;
  final String password;

  Connect({required this.username, required this.password});

  factory Connect.fromJson(Map<String, dynamic> json) =>
      _$ConnectFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectToJson(this);
}
