import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/chat/chat_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/service/chat.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/gradient_button.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';
import 'package:provider/src/provider.dart';

class NouveauChat extends StatefulWidget {
  const NouveauChat({Key? key}) : super(key: key);

  @override
  _NouveauChatState createState() => _NouveauChatState();
}

class _NouveauChatState extends State<NouveauChat> {
  final TextEditingController _controller = TextEditingController();

  Friend? selectedFriend;

  _generateConversation(BuildContext context) async {
    Friend? friendLoged =
        Provider.of<FriendNotifier>(context, listen: false).friend;
    showDialog(
        context: context,
        builder: (context) => LoadingWidget(
            label:
                'Création de la conversation avec ${selectedFriend!.prenom}'));
    APIResponse<bool> creationChannel =
        await Provider.of<ChatRepository>(context, listen: false)
            .createOneToOneChannel(
                meId: friendLoged!.id!,
                friendLinkId: selectedFriend!.id!,
                nameChannel: _controller.text);
    if (creationChannel.isSuccess) {
      Navigator.pop(context);
      if (creationChannel.data!) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Chat créé !',
          onConfirmBtnTap: () {
            Provider.of<ChatListNotifier>(context, listen: false).loadChannels(
                friendId: friendLoged.id.toString(), clearList: true);
            Navigator.pushNamedAndRemoveUntil(
                context, '/messagerie', (route) => false);
          },
        );
      }
    } else {
      Navigator.pop(context);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: creationChannel.error?.title,
          text: creationChannel.error?.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    APIResponse<List<Friend>?>? apiFriends =
        context.watch<FriendListNotifier>().listeFriends;
    return ScaffoldSortie(
      title: 'Nouvelle discussion',
      gradient: gMessagerie,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Entrer le nom de la conversation : ",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              SignTextField(
                controller: _controller,
                title: 'Nom de la conversation',
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    "Choisissez un ami avec qui discuter : ",
                    textAlign: TextAlign.center,
                  ),
                  (apiFriends != null)
                      ? DropdownButton<Friend>(
                          value: selectedFriend,
                          items: apiFriends.data!
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.prenom),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (Friend? f) {
                            setState(() {
                              selectedFriend = f!;
                            });
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
              GradientButton(
                  label: 'Valider',
                  gradient: gMessagerie,
                  onPressed: () {
                    _generateConversation(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
