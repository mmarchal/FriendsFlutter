import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/gradient_button.dart';
import 'package:life_friends/ui/widgets/sign_textfield.dart';
import 'package:provider/src/provider.dart';

class NouveauChat extends StatefulWidget {
  const NouveauChat({Key? key}) : super(key: key);

  @override
  _NouveauChatState createState() => _NouveauChatState();
}

class _NouveauChatState extends State<NouveauChat> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    APIResponse<List<Friend>?>? apiFriends =
        context.watch<FriendListNotifier>().listeFriends;
    String selectedFriend = apiFriends?.data?[0].prenom ?? "";
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
                      ? DropdownButton<String>(
                          value: selectedFriend,
                          items: apiFriends.data!
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.prenom),
                                    value: e.prenom,
                                  ))
                              .toList(),
                          onChanged: (String? s) {
                            setState(() {
                              selectedFriend = s!;
                            });
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
              GradientButton(
                  label: 'Valider', gradient: gMessagerie, onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
