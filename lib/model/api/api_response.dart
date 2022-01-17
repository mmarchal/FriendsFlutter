import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';

class APIResponse<T> {
  final T? data;
  final APIError? error;
  final FriendTypeError? type;

  APIResponse({this.data, this.type, this.error});

  bool get isSuccess => error == null && type == null;

  bool get hasInternet => type != FriendTypeError.noInternet;
}
