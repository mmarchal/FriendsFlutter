import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/provider_def.dart';
import 'package:life_friends/ui/screen/forgot_pass.dart';
import 'package:life_friends/ui/screen/friend_sortie/mes_sorties.dart';
import 'package:life_friends/ui/screen/home.dart';
import 'package:life_friends/ui/screen/login.dart';
import 'package:life_friends/ui/screen/proposition/nouvelle_proposition.dart';
import 'package:life_friends/ui/screen/signup.dart';
import 'package:life_friends/ui/screen/sortie/liste_sorties.dart';
import 'package:life_friends/ui/screen/sortie/proposition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderDef(
      child: MaterialApp(
        title: 'Friends',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          '/forgot': (context) => const ForgotPassScreen(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomeScreen(),
          '/nouvel_sortie': (context) => const PropositionSortie(),
          '/prochaines_sorties': (context) => const ListeSorties(),
          '/mes_sorties': (context) => const MesSorties(
                gradient: gPropositions,
              ),
          '/nouvelle_proposition': (context) => const NouvelleProposition(
                gradient: gPropositions,
              )
        },
      ),
    );
  }
}
