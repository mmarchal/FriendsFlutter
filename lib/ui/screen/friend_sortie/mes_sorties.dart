import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';
import 'package:provider/src/provider.dart';

class MesSorties extends StatelessWidget {
  final Gradient gradient;

  const MesSorties({Key? key, required this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TO DO voir afficher les sorties comme un "calendrier"
    Friend? friend = context.watch<FriendNotifier>().friend;
    return const ScaffoldSortie(
      title: 'Mes sorties',
      body: Center(),
      gradient: gMesSorties,
    );
  }
}
