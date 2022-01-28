import 'package:flutter/material.dart';
import 'package:life_friends/notifier/friend/friend_list_notifier.dart';
import 'package:life_friends/notifier/friend/friend_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_list_notifier.dart';
import 'package:life_friends/notifier/typesortie/typesortie_notifier.dart';
import 'package:life_friends/service/friend.repository.dart';
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
        Provider<TypeSortieRepository>(
          create: (_) => TypeSortieRepository(),
        ),
        Provider<TypeSortieNotifier>(
          create: (_) => TypeSortieNotifier(),
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
        ChangeNotifierProxyProvider<FriendNotifier, FriendListNotifier>(
            create: (context) => FriendListNotifier(context.read())
              ..loadFriends(clearList: true),
            update: (context, filter, friendListNotifier) {
              return friendListNotifier!;
            }),
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
