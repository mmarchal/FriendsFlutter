import 'package:flutter/material.dart';
import 'package:life_friends/service/api.repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiRepository().token?.username ?? ""),
      ),
      body: const Center(
        child: Text("Bonjour"),
      ),
    );
  }
}
