import 'package:flutter/material.dart';
import 'package:life_friends/provider_def.dart';
import 'package:life_friends/ui/screen/login.dart';
import 'package:life_friends/ui/screen/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderDef(
      child: MaterialApp(
        title: 'Friends',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
        },
      ),
    );
  }
}
