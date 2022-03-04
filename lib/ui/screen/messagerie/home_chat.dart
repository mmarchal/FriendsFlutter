import 'package:flutter/material.dart';
import 'package:life_friends/ui/screen/messagerie/tabs/list_of_friends.dart';
import 'package:life_friends/ui/screen/messagerie/tabs/liste_of_messages.dart';

// ignore: must_be_immutable
class HomeChat extends StatelessWidget {
  late TabController tabController;

  static const List<Widget> _bottomTabs = [
    Tab(
      icon: Icon(Icons.message),
    ),
    Tab(
      icon: Icon(Icons.supervisor_account),
    )
  ];

  static const List<Widget> _tabs = [
    ListOfMessages(),
    ListOfFriends(),
  ];

  HomeChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TabBarView(children: _tabs),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: _bottomTabs,
          controller: tabController,
        ),
      ),
    );
  }
}
