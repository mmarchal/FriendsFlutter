// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) => Password(
      userLogin: json['userLogin'] as String?,
      oldPassword: json['oldPassword'] as String?,
      token: json['token'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'userLogin': instance.userLogin,
      'oldPassword': instance.oldPassword,
      'token': instance.token,
      'newPassword': instance.newPassword,
    };
