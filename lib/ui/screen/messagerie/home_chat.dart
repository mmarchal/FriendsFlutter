import 'package:flutter/material.dart';
import 'package:life_friends/ui/screen/messagerie/tabs/list_of_friends.dart';
import 'package:life_friends/ui/screen/messagerie/tabs/liste_of_messages.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeChatState();
  }
}

class HomeChatState extends State<HomeChat> with TickerProviderStateMixin {
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

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: const TabBarView(children: _tabs),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(
            tabs: _bottomTabs,
            controller: tabController,
          ),
        ),
      ),
    );
  }
}
