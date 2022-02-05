import 'package:flutter/material.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/ui/widgets/editable_widget.dart';
import 'package:provider/src/provider.dart';

// ignore: must_be_immutable
class MyProfil extends StatelessWidget {
  TextEditingController mailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  MyProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Friend? friend = context.watch<FriendNotifier>().friend;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Votre profil',
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: (friend != null)
          ? SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      //TODO image à stocker et modifiable
                      child: Image.network(
                        'https://picsum.photos/seed/220/600',
                      ),
                    ),
                  ),
                  EditableWidget(
                    label: "Adresse mail",
                    controller: mailController,
                    value:
                        (friend.email != "") ? friend.email : "Non renseigné",
                  ),
                  EditableWidget(
                    label: "Identifiant",
                    controller: loginController,
                    value: friend.login,
                  ),
                  EditableWidget(
                    label: "Prénom",
                    controller: mailController,
                    value: friend.prenom,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Friend updateFriend = Friend(
                            prenom: nameController.text,
                            login: loginController.text,
                            email: mailController.text,
                            password: friend.password);
                        //TODO Update friend in bdd
                      },
                      child: const Text('Valider les modifications'),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
