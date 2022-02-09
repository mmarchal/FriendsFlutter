import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/service/chat.repository.dart';

class ChatListNotifier extends ChangeNotifier {
  final List<Chat> _list = [];
  final ChatRepository chatRepository;

  APIResponse<List<Chat>?>? listeChat;

  ChatListNotifier(this.chatRepository);

  Future loadChannels(
      {bool clearList = false, required String friendId}) async {
    if (clearList) _list.clear();
    APIResponse<List<Chat>> response =
        await chatRepository.getChannels(friendId);
    if (response.isSuccess) {
      _list.addAll(response.data!);
      listeChat = response;
    }
    notifyListeners();
  }
}
