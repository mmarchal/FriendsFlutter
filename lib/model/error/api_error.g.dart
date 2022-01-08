// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIError _$APIErrorFromJson(Map<String, dynamic> json) => APIError(
      systemMessage: json['systemMessage'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$APIErrorToJson(APIError instance) => <String, dynamic>{
      'systemMessage': instance.systemMessage,
      'title': instance.title,
      'content': instance.content,
    };
