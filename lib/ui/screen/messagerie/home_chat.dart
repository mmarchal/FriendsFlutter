import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/chat/chat_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/gradient_button.dart';
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
    APIResponse<List<Friend>?>? apiFriends =
        context.watch<FriendListNotifier>().listeFriends;
    return ScaffoldSortie(
        title: 'Messagerie',
        gradient: gMessagerie,
        actionAppBar: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return generateAlertDialog(apiFriends);
              },
            );
          },
        ),
        body: (api != null)
            ? generateBody(api)
            : const Center(child: CircularProgressIndicator()));
  }

  Widget generateBody(APIResponse<List<Chat>?> apiResponse) {
    if (apiResponse.isSuccess && apiResponse.data!.isNotEmpty) {
      List<Chat> _list = apiResponse.data!;
      return ListView.builder(
        itemCount: _list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Chat chat = _list[index];
          return InkWell(
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: ListTile(
                title: Text(chat.name),
                subtitle: Text((chat.messagesList != null &&
                        chat.messagesList!.isNotEmpty)
                    ? "Dernier message le ${DateFormat("dd/MM/yyyy hh:mm").format(chat.messagesList!.last.deliveredAt)}"
                    : "Aucun message !"),
              ),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: Text("Aucun message n'a été trouvé ! ",
            style: TextStyle(fontStyle: FontStyle.italic)),
      );
    }
  }

  Widget generateAlertDialog(APIResponse<List<Friend>?>? apiFriends) {
    return SimpleDialog(
        title: const Text(
          "Choisissez un ami avec qui discuter: ",
          textAlign: TextAlign.center,
        ),
        children: apiFriends!.data!
            .map((e) => GradientButton(
                  label: e.prenom,
                  onPressed: () {},
                  gradient: gMessagerie,
                ))
            .toList());
  }
}
