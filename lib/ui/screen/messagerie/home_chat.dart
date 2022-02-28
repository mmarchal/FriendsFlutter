import 'package:flutter/material.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: []),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: [],
          controller: tabController,
        ),
      ),
    );
  }
}
