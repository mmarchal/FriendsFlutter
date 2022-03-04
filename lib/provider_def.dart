import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_friends/login_service.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_list_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/notifier/typeproposition/typeproposition_list_notifier.dart';
import 'package:life_friends/notifier/typeproposition/typeproposition_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_list_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_notifier.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/service/sortie.repository.dart';
import 'package:life_friends/service/typeproposition.repository.dart';
import 'package:life_friends/service/typesortie.repository.dart';
import 'package:provider/provider.dart';

class ProviderDef extends StatelessWidget {
  final Widget child;

  const ProviderDef({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<Dio>(
          create: (_) => Dio(),
        ),
        Provider<LoginService>(
          create: (_) => LoginService(),
        ),
        Provider<FirebaseAuth>(
          create: (_) => FirebaseAuth.instance,
        ),

        // ------ Repositories ------

        // Token
        Provider<TokenNotifier>(
          create: (_) => TokenNotifier(),
        ),
        ChangeNotifierProvider<TokenNotifier>(
          create: (context) => TokenNotifier(),
        ),

        // Friend
        Provider<FriendRepository>(
          create: (context) => FriendRepository(context.read(), context.read()),
        ),
        ChangeNotifierProvider<FriendNotifier>(
          create: (_) => FriendNotifier(),
        ),
        ChangeNotifierProxyProvider<FriendNotifier, FriendListNotifier>(
            create: (context) => FriendListNotifier(context.read())
              ..loadFriends(clearList: true),
            update: (context, filter, friendListNotifier) {
              return friendListNotifier!;
            }),

        //Type de sortie
        Provider<TypeSortieRepository>(
          create: (_) => TypeSortieRepository(),
        ),
        Provider<TypeSortieNotifier>(
          create: (_) => TypeSortieNotifier(),
        ),
        ChangeNotifierProvider<TypeSortieNotifier>(
          create: (_) => TypeSortieNotifier(),
        ),
        ChangeNotifierProxyProvider<TypeSortieNotifier, TypeSortieListNotifier>(
          create: (context) => TypeSortieListNotifier(context.read())
            ..loadTypesSorties(clearList: true),
          update: (context, filter, typeSortiesList) {
            return typeSortiesList!;
          },
        ),

        // Sortie
        Provider<SortieRepository>(
          create: (_) => SortieRepository(),
        ),
        ChangeNotifierProvider<SortieNotifier>(create: (_) => SortieNotifier()),
        ChangeNotifierProxyProvider<SortieNotifier, SortieListNotifier>(
          create: (context) =>
              SortieListNotifier(context.read(), context.read())
                ..loadAllSorties(clearList: true),
          update: (context, value, previous) {
            return previous!;
          },
        ),

        // Type de propositions
        Provider<TypePropositionNotifier>(
          create: (_) => TypePropositionNotifier(),
        ),
        Provider<TypePropositionRepository>(
          create: (_) => TypePropositionRepository(),
        ),
        Provider<TypePropositionListNotifier>(
          create: (_) => TypePropositionListNotifier(context.read()),
        ),
        ChangeNotifierProxyProvider<TypePropositionNotifier,
            TypePropositionListNotifier>(
          create: (context) => TypePropositionListNotifier(context.read())
            ..loadTypesPropositions(clearList: true),
          update: (context, filter, typePropositionsList) {
            return typePropositionsList!;
          },
        ),
      ],
      child: child,
    );
  }
}
