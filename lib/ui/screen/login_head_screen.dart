import 'package:flutter/material.dart';
import 'package:life_friends/ui/utils/style.dart';
import 'package:life_friends/ui/widgets/login_right_text.dart';

class LoginHeadScreen extends StatelessWidget {
  final Widget child;
  final String value;

  const LoginHeadScreen({
    Key? key,
    required this.child,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: Style().boxDeco,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                LoginRightText(
                  title: value,
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 62),
              child: child),
        ],
      ),
    );
  }
}
