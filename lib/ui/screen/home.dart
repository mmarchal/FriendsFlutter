import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/ui/screen/friend_sortie/mes_sorties.dart';
import 'package:life_friends/ui/widgets/friend_app_bar.dart';
import 'package:life_friends/ui/widgets/gradient_icon_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var friend = context.watch<FriendNotifier>().friend;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FriendAppBar(
        username: "Hello ${friend?.prenom ?? ""}",
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientIconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/nouvel_sortie"),
                  icon: Icons.add,
                  gradient: gNewSortie,
                  label: "Proposer une sortie"),
              GradientIconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/prochaines_sorties"),
                  icon: Icons.calendar_today,
                  gradient: gNextSorties,
                  label: "Voir les prochaines sorties"),
              GradientIconButton(
                  onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext bC) {
                        return MesSorties(
                            gradient: gMesSorties,
                            userId: (friend?.id.toString() ?? ""));
                      })),
                  icon: Icons.my_library_add,
                  gradient: gMesSorties,
                  label: "Mes sorties"),
              GradientIconButton(
                  onPressed: () => Navigator.pushNamed(context, "/messagerie"),
                  icon: Icons.message,
                  gradient: gMessagerie,
                  label: "Messagerie"),
              GradientIconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/nouvelle_proposition"),
                  icon: Icons.vertical_distribute_rounded,
                  gradient: gPropositions,
                  label: "Propositions"),
            ],
          ),
        ),
      ),
    );
  }
}
