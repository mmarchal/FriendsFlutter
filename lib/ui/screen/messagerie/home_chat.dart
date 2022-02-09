import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/chat/chat_list_notifier.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:provider/src/provider.dart';

class HomeChat extends StatefulWidget {
  final Friend? user;

  const HomeChat({Key? key, this.user}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    APIResponse<List<Chat>?>? api = context.watch<ChatListNotifier>().listeChat;
    return ScaffoldSortie(
        title: 'Messagerie',
        gradient: gMessagerie,
        body: (api != null)
            ? const Center(
                child: Text("Coucou"),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
