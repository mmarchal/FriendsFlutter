import 'package:flutter/material.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  late TabController tabController;

  static const List<Widget> _bottomTabs = [
    Tab(
      icon: Icon(Icons.message),
    ),
    Tab(
      icon: Icon(Icons.supervisor_account),
    ),
    Tab(
      icon: Icon(Icons.account_circle),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: []),
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
