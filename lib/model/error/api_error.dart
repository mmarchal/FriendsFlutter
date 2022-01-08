import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class APIError {
  final String systemMessage;
  final String title;
  final String content;

  APIError(
      {required this.systemMessage,
      required this.title,
      required this.content});

  factory APIError.fromJson(Map<String, dynamic> json) =>
      _$APIErrorFromJson(json);

  Map<String, dynamic> toJson() => _$APIErrorToJson(this);
}
