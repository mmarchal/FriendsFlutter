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
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';
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
        body: (api != null && apiFriends != null)
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
    TextEditingController _controller = TextEditingController();
    String selectedFriend = "";
    List<DropdownMenuItem<String>> friendsItem = [];
    if (apiFriends != null) {
      friendsItem = apiFriends.data!
          .map((e) => DropdownMenuItem(
                child: Text(e.prenom),
                value: e.prenom,
              ))
          .toList();
    }
    return SimpleDialog(
        title: const Text(
          "Entrer le nom de la conversation et choisissez un ami avec qui discuter: ",
          textAlign: TextAlign.center,
        ),
        children: [
          Expanded(
              child: SignTextField(
            controller: _controller,
            title: 'Nom de la conversation',
          )),
          const SizedBox(
            height: 30,
          ),
          (friendsItem.isNotEmpty)
              ? DropdownButton(
                  value: selectedFriend,
                  items: friendsItem,
                  onChanged: (String? s) {
                    setState(() {
                      selectedFriend = s!;
                    });
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          GradientButton(
              label: 'Valider',
              gradient: gMessagerie,
              onPressed: () {
                _generateChat(selectedFriend);
              })
        ]);
  }

  _generateChat(String e) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return LoadingWidget(label: "Création de la conversation avec $e");
        });
  }
}
