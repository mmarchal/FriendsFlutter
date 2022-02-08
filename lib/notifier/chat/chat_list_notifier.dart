import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';

class ChatListNotifier extends ChangeNotifier {
  final List<Chat> _list = [];
  final ChatRepository chatRepository;

  APIResponse<List<Chat>?>? listeChat;

  ChatListNotifier(this.chatRepository);

  Future loadAccessChat({bool clearList = false}) async {
    if (clearList) _list.clear();
  }
}
