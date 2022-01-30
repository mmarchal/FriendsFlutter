import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class Password {
  final String? userLogin;
  final String? oldPassword;
  final String token;
  final String newPassword;

  Password(
      {required this.userLogin,
      this.oldPassword,
      required this.token,
      required this.newPassword});

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordToJson(this);
}
