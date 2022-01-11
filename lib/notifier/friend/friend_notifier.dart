import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/friend.dart';

class FriendNotifier extends ChangeNotifier {
  Friend? friend;

  FriendNotifier({this.friend});

  setToken(Friend? friend) {
    this.friend = friend;
    notifyListeners();
  }
}
