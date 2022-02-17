import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/provider_def.dart';
import 'package:life_friends/ui/screen/forgot_pass.dart';
import 'package:life_friends/ui/screen/friend_sortie/mes_sorties.dart';
import 'package:life_friends/ui/screen/home.dart';
import 'package:life_friends/ui/screen/login.dart';
import 'package:life_friends/ui/screen/messagerie/detail/detail_chat.dart';
import 'package:life_friends/ui/screen/messagerie/home_chat.dart';
import 'package:life_friends/ui/screen/messagerie/nouveau_chat.dart';
import 'package:life_friends/ui/screen/profil/my_profil.dart';
import 'package:life_friends/ui/screen/proposition/nouvelle_proposition.dart';
import 'package:life_friends/ui/screen/signup.dart';
import 'package:life_friends/ui/screen/sortie/detail_sortie.dart';
import 'package:life_friends/ui/screen/sortie/liste_sorties.dart';
import 'package:life_friends/ui/screen/sortie/proposition.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', ''),
        ],
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
                userId: '',
              ),
          '/nouvelle_proposition': (context) => const NouvelleProposition(
                gradient: gPropositions,
              ),
          '/detail_sortie': (context) => const DetailSortie(),
          '/profil': (context) => const MyProfil(),
          '/messagerie': (context) => HomeChat(
                user: context.watch<FriendNotifier>().friend,
              ),
          '/nouvelle_discussion': (context) => const NouveauChat(),
          '/detail_chat': (context) => DetailChat(
                chat: ModalRoute.of(context)!.settings.arguments as Chat,
              )
        },
      ),
    );
  }
}
