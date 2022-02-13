import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/screen/profil/widgets/profil_information_row.dart';
import 'package:life_friends/ui/utils/hexcolor.dart';
import 'package:life_friends/ui/widgets/advance_custom_alert.dart';
import 'package:life_friends/ui/widgets/copper_text.dart';
import 'package:life_friends/ui/widgets/loading_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:random_string/random_string.dart';

enum Updated { prenom, mail, identifiant }

// ignore: must_be_immutable
class MyProfil extends StatefulWidget {
  const MyProfil({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyProfilState();
  }
}

class MyProfilState extends State<MyProfil> {
  TextEditingController mailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool mailUpdated = false;
  bool loginUpdated = false;
  bool nameUpdated = false;

  _titleDialogUpdate(Updated updated) {
    switch (updated) {
      case Updated.prenom:
        return "Modifier le prénom";
      case Updated.mail:
        return "Modifier l'adresse mail";
      case Updated.identifiant:
        return "Modifier l'identifiant";
      default:
        return "Modifier";
    }
  }

  _valueDialogUpdate(Updated updated, Friend friend) {
    switch (updated) {
      case Updated.prenom:
        return friend.prenom;
      case Updated.mail:
        return friend.email;
      case Updated.identifiant:
        return friend.login;
    }
  }

  _controllerUpdated(Updated updated) {
    switch (updated) {
      case Updated.identifiant:
        return loginController;
      case Updated.mail:
        return mailController;
      case Updated.prenom:
        return nameController;
    }
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Updated updated, Friend friend) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: CopperPlateText(
              label: _titleDialogUpdate(updated),
              color: Colors.black,
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CopperPlateText(
                    label: "Actuel : ${_valueDialogUpdate(updated, friend)}",
                    color: Colors.black),
                TextField(
                  controller: _controllerUpdated(updated),
                )
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: const Text('Valider'),
                onPressed: () {
                  setState(() {
                    switch (updated) {
                      case Updated.identifiant:
                        loginUpdated = true;
                        break;
                      case Updated.mail:
                        mailUpdated = true;
                        break;
                      case Updated.prenom:
                        nameUpdated = true;
                        break;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  String _checkChangedValue(Friend? friend) {
    String allChangements = "";
    if (loginUpdated) {
      allChangements +=
          "Identifiant modifié : ${loginController.text} (${friend?.login})\n";
    }
    if (nameUpdated) {
      allChangements +=
          "Prénom modifié : ${nameController.text} (${friend?.prenom})\n";
    }
    if (mailUpdated) {
      allChangements +=
          "Email modifié : ${mailController.text} (${friend?.email})\n";
    }
    return allChangements;
  }

  _alertPopupChangements(BuildContext context, Friend? friend) async {
    String changed = _checkChangedValue(friend);
    await CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: 'Confirmation de modification',
        onConfirmBtnTap: () {
          if (changed == "") {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else {
            Navigator.pop(context);
            _validateChangements(context, friend);
          }
        },
        text: changed);
  }

  _validateChangements(BuildContext context, Friend? friend) {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingWidget(label: "Modification en cours");
        });
    Friend updateFriend = Friend(
        id: friend!.id,
        prenom: (nameUpdated) ? nameController.text : friend.prenom,
        login: (loginUpdated) ? loginController.text : friend.login,
        email: (mailUpdated) ? mailController.text : friend.email,
        password: friend.password);
    Provider.of<FriendRepository>(context, listen: false)
        .updateUser(updateFriend)
        .then((value) async {
      Navigator.pop(context);
      if (value.isSuccess) {
        Provider.of<FriendNotifier>(context, listen: false)
            .setFriend(value.data);
        await CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Modification effectué ! !',
            onConfirmBtnTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AdvanceCustomAlert<Friend>(response: value);
            });
      }
    });
  }

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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _alertPopupChangements(context, friend);
          },
          child: const Icon(Icons.check)),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Card(
            color: HexColor("#dff5e9"),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: HexColor("#134287"),
                    padding: const EdgeInsets.all(8.0),
                    child: CopperPlateText(
                      label: "FRIEND",
                      textAlign: TextAlign.center,
                      color: Colors.white,
                    )),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfilInformationRow(
                          label: "Prénom :",
                          value: (nameUpdated)
                              ? nameController.text
                              : friend?.prenom ?? "",
                          updated: nameUpdated,
                          onPressed: () {
                            _displayTextInputDialog(
                                context, Updated.prenom, friend!);
                          },
                          onReinitValue: () {
                            setState(() {
                              nameUpdated = false;
                              nameController.clear();
                            });
                          },
                        ),
                        ProfilInformationRow(
                          label: "Adresse mail :",
                          value: (mailUpdated)
                              ? mailController.text
                              : friend?.email ?? "",
                          updated: mailUpdated,
                          onPressed: () {
                            _displayTextInputDialog(
                                context, Updated.mail, friend!);
                          },
                          onReinitValue: () {
                            setState(() {
                              mailUpdated = false;
                              mailController.clear();
                            });
                          },
                        ),
                        ProfilInformationRow(
                          label: "Identifiant :",
                          value: (loginUpdated)
                              ? loginController.text
                              : friend?.login ?? "",
                          updated: loginUpdated,
                          onPressed: () {
                            _displayTextInputDialog(
                                context, Updated.identifiant, friend!);
                          },
                          onReinitValue: () {
                            setState(() {
                              loginUpdated = false;
                              loginController.clear();
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(8.0),
                    child: CopperPlateText(
                      label: "FRIEND",
                      textAlign: TextAlign.center,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}