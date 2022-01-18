import 'package:flutter/material.dart';
import 'package:life_friends/notifier/sortie/sortie_notifier.dart';
import 'package:life_friends/notifier/token_notifier.dart';
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
        ChangeNotifierProvider<TokenNotifier>(
          create: (context) => TokenNotifier(),
        ),
      ],
      child: child,
    );
  }
}
