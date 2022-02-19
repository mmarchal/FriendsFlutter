import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/api/back/auth_token.dart';

class TokenNotifier extends ChangeNotifier {
  AuthToken? token;
  String? domain;

  TokenNotifier({this.token, this.domain});

  setToken(AuthToken? token) {
    this.token = token;
    notifyListeners();
  }

  setEnvironment(String? domain) {
    this.domain = domain;
    notifyListeners();
  }
}
