import 'package:flutter/cupertino.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/service/friend.repository.dart';

class FriendListNotifier extends ChangeNotifier {
  final List<Friend> _list = [];
  final FriendRepository friendRepository;

  APIResponse<List<Friend>?>? listeFriends;

  FriendListNotifier(this.friendRepository);

  Future loadFriends({bool clearList = false}) async {
    if (clearList) _list.clear();
    APIResponse<List<Friend>> response = await friendRepository.getFriends();
    if (response.isSuccess) {
      _list.addAll(response.data!);
      listeFriends = response;
    }
    notifyListeners();
  }
}
