// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      from: json['from'] as String,
      to: json['to'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String,
      dateString: json['dateString'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'dateString': instance.dateString,
    };
