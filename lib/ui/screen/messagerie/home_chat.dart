import 'package:flutter/material.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/ui/screen/sortie/scaffold_sortie.dart';

class HomeChat extends StatefulWidget {
  final Friend? user;

  const HomeChat({Key? key, this.user}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldSortie(
      title: 'Messagerie',
      gradient: gMessagerie,
      body: Center(),
    );
  }
}
