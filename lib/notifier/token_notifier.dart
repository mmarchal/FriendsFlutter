import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/api/back/auth_token.dart';

class TokenNotifier extends ChangeNotifier {
  AuthToken? token;

  TokenNotifier({this.token});

  setToken(AuthToken? token) {
    this.token = token;
    notifyListeners();
  }
}
