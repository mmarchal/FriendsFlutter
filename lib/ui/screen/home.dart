import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/ui/screen/sortie/liste_sorties.dart';
import 'package:life_friends/ui/screen/sortie/proposition.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authToken = context.watch<TokenNotifier>().token;
    return Scaffold(
      appBar: AppBar(
        title: Text(authToken?.username ?? ""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext bC) {
                    return const PropositionSortie();
                  }));
                },
                child: const Text("Proposer une sortie")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext bC) {
                    return const ListeSorties();
                  }));
                },
                child: const Text("Voir les prochaines sorties")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Voir mes sorties")),
            ElevatedButton(onPressed: () {}, child: const Text("Messagerie")),
            ElevatedButton(onPressed: () {}, child: const Text("Propositions"))
          ],
        ),
      ),
    );
  }
}
