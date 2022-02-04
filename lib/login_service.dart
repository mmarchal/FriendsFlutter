import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/api/back/auth_token.dart';

class LoginService {
  late AuthToken? token;

  void storeToken(ApiBack back) {
    token =
        AuthToken(back.result.token, back.result.username, back.result.userId);
  }

  void logout() {
    token = null;
  }
}
