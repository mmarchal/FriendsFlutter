import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_list_notifier.dart';
import 'package:life_friends/service/sortie.repository.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ScaffoldSortie extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final Widget body;
  final bool? inscription;
  final VoidCallback? onConfirm;
  final Sortie? sortie;

  const ScaffoldSortie(
      {Key? key,
      required this.title,
      required this.body,
      this.inscription = false,
      this.sortie,
      required this.gradient,
      this.onConfirm})
      : super(key: key);

  _showDialogError(String error, BuildContext context) {
    return CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Erreur lors de l'inscription",
        text: "Une erreur est survenu --> $error");
  }

  _addFriend(Friend? friend, BuildContext context) {
    if (friend != null && sortie != null) {
      SortieRepository().addFriendToOuting(friend, sortie!).then((value) {
        if (value.data!) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              barrierDismissible: true,
              onConfirmBtnTap: onConfirm,
              title: "Inscription",
              text: "Vous êtes bien inscrit !");
        } else {
          _showDialogError("Contactez l'administrateur !", context);
        }
      }).onError((error, stackTrace) {
        _showDialogError(error.toString(), context);
      });
    } else {
      _showDialogError("Contactez l'administrateur !", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Friend? friend = context.watch<FriendNotifier>().friend;
    return Scaffold(
      backgroundColor: gradient.colors[0],
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: gradient.colors[1],
        actions: [
          if (inscription!)
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext bc) {
                        return AlertDialog(
                          title: const Text(
                            "Inscription",
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                            "Voulez-vous vous inscrire à cette sortie ?",
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _addFriend(friend, context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Oui")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Non")),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ))
        ],
      ),
      body: body,
    );
  }
}
