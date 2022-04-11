// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      uid: json['uid'] as String,
      login: json['login'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      password: json['password'] as String,
      mdpProvisoire: json['mdpProvisoire'] as bool?,
      codeMdp: json['codeMdp'] as String?,
      dateExpiration: json['dateExpiration'] == null
          ? null
          : DateTime.parse(json['dateExpiration'] as String),
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'uid': instance.uid,
      'login': instance.login,
      'prenom': instance.prenom,
      'password': instance.password,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'mdpProvisoire': instance.mdpProvisoire,
      'codeMdp': instance.codeMdp,
      'dateExpiration': instance.dateExpiration?.toIso8601String(),
    };
