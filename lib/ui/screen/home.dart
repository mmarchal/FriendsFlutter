import 'package:flutter/material.dart';
import 'package:life_friends/notifier/token_notifier.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authToken = context.watch<TokenNotifier>().token;
    return Scaffold(
      appBar: AppBar(
        title: Text(authToken?.username ?? ""),
      ),
      body: const Center(
        child: Text("Bonjour"),
      ),
    );
  }
}
