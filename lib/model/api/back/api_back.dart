import 'package:json_annotation/json_annotation.dart';
import 'package:life_friends/model/api/back/auth_token.dart';

part 'api_back.g.dart';

@JsonSerializable()
class ApiBack {
  final int status;
  final String message;
  final AuthToken result;

  ApiBack(this.status, this.message, this.result);

  factory ApiBack.fromJson(Map<String, dynamic> json) =>
      _$ApiBackFromJson(json);

  Map<String, dynamic> toJson() => _$ApiBackToJson(this);
}
