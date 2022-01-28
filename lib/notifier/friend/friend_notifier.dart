import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/api/back/auth_token.dart';
import 'package:life_friends/model/friend.dart';

class FriendNotifier extends ChangeNotifier {
  Friend? friend;
  AuthToken? token;

  FriendNotifier({this.friend});

  setFriend(Friend? friend) {
    this.friend = friend;
    notifyListeners();
  }

  setToken(AuthToken? token) {
    this.token = token;
    notifyListeners();
  }
}
