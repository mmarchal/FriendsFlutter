import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_notifier.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:provider/src/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

// ignore: must_be_immutable
class MesSorties extends StatefulWidget {
  final Gradient gradient;
  final String userId;

  const MesSorties({Key? key, required this.gradient, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MesSorties();
  }
}

class _MesSorties extends State<MesSorties> {
  APIResponse<List<Sortie>>? apiSorties;

  ///To do --> Style à modifier
  ///https://miro.medium.com/max/910/1*xvCsoq7iYcznw1Xy5A8Jng.png

  @override
  void initState() {
    super.initState();

    if (widget.userId != '') {
      FriendRepository().getMySorties(widget.userId).then((value) {
        setState(() {
          apiSorties = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //TO DO voir afficher les sorties comme un "calendrier"
    return ScaffoldSortie(
      title: 'Mes sorties',
      body: (apiSorties != null)
          ? GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              itemCount: apiSorties?.data!.length,
              itemBuilder: (context, index) {
                Sortie sortie = apiSorties!.data![index];
                return Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sortie.intitule),
                      Text(sortie.datePropose?.toIso8601String() ??
                          "Pas de date prévu !"),
                      Text(sortie.typeSortie.type)
                    ],
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
      gradient: gMesSorties,
    );
  }
}
