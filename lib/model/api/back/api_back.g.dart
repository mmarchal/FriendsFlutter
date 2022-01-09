// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_back.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiBack _$ApiBackFromJson(Map<String, dynamic> json) => ApiBack(
      json['status'] as int,
      json['message'] as String,
      AuthToken.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiBackToJson(ApiBack instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };
