import 'package:flutter/material.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/ui/widgets/friend_app_bar.dart';
import 'package:life_friends/ui/widgets/gradient_icon_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final Gradient gNewSortie = const LinearGradient(colors: [
    Color(0xFF5c8dff),
    Color(0xFF44d1ee),
  ]);

  final Gradient gNextSorties = const LinearGradient(colors: [
    Color(0xFF3b4254),
    Color(0xFFc2c2c1),
  ]);

  final Gradient gMesSorties = const LinearGradient(colors: [
    Color(0xFF307e51),
    Color(0xFF71f4c2),
  ]);

  final Gradient gMessagerie = const LinearGradient(colors: [
    Color(0xFFff0000),
    Color(0xFFffd747),
  ]);

  final Gradient gPropositions = const LinearGradient(colors: [
    Color(0xFF7e3030),
    Color(0xFF8e71f4),
  ]);

  @override
  Widget build(BuildContext context) {
    var authToken = context.watch<TokenNotifier>().token;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FriendAppBar(
        username: authToken?.username,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientIconButton(
                onPressed: () => Navigator.pushNamed(context, "/nouvel_sortie"),
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
                onPressed: () => Navigator.pushNamed(context, "/mes_sorties"),
                icon: Icons.my_library_add,
                gradient: gMesSorties,
                label: "Mes sorties"),
            GradientIconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/prochaines_sorties"),
                icon: Icons.message,
                gradient: gMessagerie,
                label: "Messagerie"),
            GradientIconButton(
                onPressed: () => Navigator.pushNamed(context, "/propositions"),
                icon: Icons.vertical_distribute_rounded,
                gradient: gPropositions,
                label: "Propositions"),
          ],
        ),
      ),
    );
  }
}
