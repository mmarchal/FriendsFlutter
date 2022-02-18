// ignore_for_file: implementation_imports

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_list_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/detail_type_sortie.dart';
import 'package:life_friends/ui/widgets/friend_card_sortie.dart';
import 'package:life_friends/ui/widgets/participant_sortie.dart';
import 'package:provider/src/provider.dart';

class DetailSortie extends StatefulWidget {
  const DetailSortie({Key? key}) : super(key: key);

  @override
  _DetailSortieState createState() => _DetailSortieState();
}

class _DetailSortieState extends State<DetailSortie> {
  List<int> liste = [];

  _showDialogError(String error, BuildContext context) {
    return CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Erreur lors de l'inscription",
        text: "Une erreur est survenu --> $error");
  }

  _addFriend(Friend? friend, BuildContext context, Sortie? sortie) {
    if (friend != null && sortie != null) {
      SortieRepository().addFriendToOuting(friend, sortie).then((value) {
        if (value.data!) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              barrierDismissible: true,
              onConfirmBtnTap: () {
                var idFriend =
                    Provider.of<TokenNotifier>(context, listen: false)
                        .token!
                        .userId;
                setState(() {
                  liste.add(idFriend);
                });
                Navigator.pop(context);
              },
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
    APIResponse<Sortie>? apiSortie =
        context.watch<SortieListNotifier>().uniqueSortie;
    Friend? friend = context.watch<FriendNotifier>().friend;

    Sortie? sortie = apiSortie?.data;
    return ScaffoldSortie(
      title: sortie?.intitule ?? "",
      actionAppBar: IconButton(
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
                            _addFriend(friend, context, sortie);
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
          )),
      sortie: sortie,
      body: (sortie != null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: DetailTypeSortie(
                      typeSortie: sortie.typeSortie,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Les informations :",
                          textScaleFactor: 2,
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        FriendCardSortie(
                            title: "Date",
                            subTitle: (sortie.datePropose != null)
                                ? DateFormat('dd/MM/yyyy')
                                    .format(sortie.datePropose!)
                                : "Aucune date renseigné !",
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.white)),
                        FriendCardSortie(
                            title: "Lieu",
                            subTitle: sortie.lieu,
                            icon: const Icon(Icons.map, color: Colors.white)),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          child: const Text(
                            "Les participants :",
                            textScaleFactor: 2,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        ParticipantSortie(
                          listeIdParticipants:
                              getAllIdParticipants(sortie.friends),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      gradient: gNextSorties,
    );
  }

  List<int> getAllIdParticipants(List<Friend>? friends) {
    friends?.forEach((element) {
      liste.add(element.id!);
    });
    return liste;
  }
}
