import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/model/message.dart';
import 'package:life_friends/service/chat.repository.dart';

class ChatListNotifier extends ChangeNotifier {
  final List<Chat> _list = [];
  final List<Message> _listMessage = [];
  final ChatRepository chatRepository;

  APIResponse<List<Chat>?>? listeChat;
  APIResponse<List<Message>?>? listeMessages;

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

  Future getMessagesFromChannel(
      {bool clearList = false, required String channelId}) async {
    if (clearList) _list.clear();
    APIResponse<List<Message>> response =
        await chatRepository.getMessagesFromChannel(channelId);
    if (response.isSuccess) {
      _listMessage.addAll(response.data!);
      listeMessages = response;
    }
    notifyListeners();
  }
}
