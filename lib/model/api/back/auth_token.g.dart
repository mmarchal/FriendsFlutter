// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
      json['token'] as String,
      json['username'] as String,
      json['userId'] as String,
    );

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
      'token': instance.token,
      'username': instance.username,
      'userId': instance.userId,
    };
