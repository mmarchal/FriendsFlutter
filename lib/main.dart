import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/provider_def.dart';
import 'package:life_friends/ui/screen/forgot_pass.dart';
import 'package:life_friends/ui/screen/friend_sortie/mes_sorties.dart';
import 'package:life_friends/ui/screen/home.dart';
import 'package:life_friends/ui/screen/login.dart';
import 'package:life_friends/ui/screen/messagerie/home_chat.dart';
import 'package:life_friends/ui/screen/profil/my_profil.dart';
import 'package:life_friends/ui/screen/proposition/nouvelle_proposition.dart';
import 'package:life_friends/ui/screen/signup.dart';
import 'package:life_friends/ui/screen/sortie/detail_sortie.dart';
import 'package:life_friends/ui/screen/sortie/liste_sorties.dart';
import 'package:life_friends/ui/screen/sortie/proposition.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(
    name: 'FriendChat',
    options: firebaseOptions,
  );
  /*
  Firebase Cloud Messaging
  https://medium.com/firebase-tips-tricks/how-to-use-firebase-cloud-messaging-in-flutter-a15ca69ff292
   */
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
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
          '/': (context) => LoginPage(),
          '/forgot': (context) => const ForgotPassScreen(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomeScreen(),
          '/nouvel_sortie': (context) => const PropositionSortie(),
          '/prochaines_sorties': (context) => const ListSorties(),
          '/mes_sorties': (context) => const MesSorties(
                gradient: gPropositions,
                userId: '',
              ),
          '/nouvelle_proposition': (context) => const NouvelleProposition(
                gradient: gPropositions,
              ),
          '/detail_sortie': (context) => DetailSortie(
                sortieId: ModalRoute.of(context)!.settings.arguments as int,
              ),
          '/profil': (context) => const MyProfil(),
          '/messagerie': (context) => const HomeChat(),
        },
      ),
    );
  }
}
