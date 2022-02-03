import 'package:flutter/material.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/sortie/sortie_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/notifier/typeproposition/typeproposition_list_notifier.dart';
import 'package:life_friends/notifier/typeproposition/typeproposition_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_list_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_notifier.dart';
import 'package:life_friends/service/friend.repository.dart';
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
        Provider<TokenNotifier>(
          create: (_) => TokenNotifier(),
        ),
        Provider<FriendRepository>(
          create: (_) => FriendRepository(),
        ),
        Provider<SortieNotifier>(create: (_) => SortieNotifier()),
        Provider<TypeSortieRepository>(
          create: (_) => TypeSortieRepository(),
        ),
        Provider<TypeSortieNotifier>(
          create: (_) => TypeSortieNotifier(),
        ),
        Provider<TypePropositionNotifier>(
          create: (_) => TypePropositionNotifier(),
        ),
        Provider<TypePropositionRepository>(
          create: (_) => TypePropositionRepository(),
        ),
        Provider<TypePropositionListNotifier>(
          create: (_) => TypePropositionListNotifier(context.read()),
        ),
        ChangeNotifierProvider<FriendNotifier>(
          create: (_) => FriendNotifier(),
        ),
        ChangeNotifierProvider<TokenNotifier>(
          create: (context) => TokenNotifier(),
        ),
        ChangeNotifierProvider<TypeSortieNotifier>(
          create: (_) => TypeSortieNotifier(),
        ),
        ChangeNotifierProvider<SortieNotifier>(
            create: (_) => SortieNotifier()..loadAllSorties(clearList: true)),
        ChangeNotifierProxyProvider<FriendNotifier, FriendListNotifier>(
            create: (context) => FriendListNotifier(context.read())
              ..loadFriends(clearList: true),
            update: (context, filter, friendListNotifier) {
              return friendListNotifier!;
            }),
        ChangeNotifierProxyProvider<TypePropositionNotifier,
            TypePropositionListNotifier>(
          create: (context) => TypePropositionListNotifier(context.read())
            ..loadTypesPropositions(clearList: true),
          update: (context, filter, typePropositionsList) {
            return typePropositionsList!;
          },
        ),
        ChangeNotifierProxyProvider<TypeSortieNotifier, TypeSortieListNotifier>(
          create: (context) => TypeSortieListNotifier(context.read())
            ..loadTypesSorties(clearList: true),
          update: (context, filter, typeSortiesList) {
            return typeSortiesList!;
          },
        )
      ],
      child: child,
    );
  }
}
