import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:life_friends/ui/widgets/detail_type_sortie.dart';
import 'package:life_friends/ui/widgets/friend_card_sortie.dart';
import 'package:life_friends/ui/widgets/participant_sortie.dart';

class DetailSortie extends StatefulWidget {
  final Sortie sortie;

  const DetailSortie({Key? key, required this.sortie}) : super(key: key);

  @override
  _DetailSortieState createState() => _DetailSortieState();
}

class _DetailSortieState extends State<DetailSortie> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldSortie(
      title: widget.sortie.intitule,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: DetailTypeSortie(
                typeSortie: widget.sortie.typeSortie,
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
                      subTitle: (widget.sortie.datePropose != null)
                          ? DateFormat('dd/MM/yyyy')
                              .format(widget.sortie.datePropose!)
                          : "Aucune date renseigné !",
                      icon: const Icon(Icons.calendar_today,
                          color: Colors.white)),
                  FriendCardSortie(
                      title: "Lieu",
                      subTitle: widget.sortie.lieu,
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
                        getAllIdParticipants(widget.sortie.friends),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> getAllIdParticipants(List<Friend>? friends) {
    List<int> liste = [];
    friends?.forEach((element) {
      liste.add(element.id!);
    });
    return liste;
  }
}
