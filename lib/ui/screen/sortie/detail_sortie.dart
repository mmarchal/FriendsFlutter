import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/sortie/sortie_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
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

  @override
  Widget build(BuildContext context) {
    APIResponse<Sortie>? apiSortie =
        context.watch<SortieNotifier>().uniqueSortie;
    Sortie? sortie = apiSortie?.data;
    return ScaffoldSortie(
      title: sortie?.intitule ?? "",
      inscription: true,
      sortie: sortie,
      onConfirm: () {
        var idFriend =
            Provider.of<TokenNotifier>(context, listen: false).token!.userId;
        setState(() {
          liste.add(idFriend);
        });
        Navigator.pop(context);
      },
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
