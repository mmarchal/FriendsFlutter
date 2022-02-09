// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int,
      content: json['content'] as String,
      deliveredAt: DateTime.parse(json['deliveredAt'] as String),
      friend: Friend.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'deliveredAt': instance.deliveredAt.toIso8601String(),
      'friend': instance.friend,
    };
